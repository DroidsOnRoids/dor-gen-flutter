import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dor_gen/src/annotations/dto.dart';
import 'package:dor_gen/src/annotations/dto_config_annotation.dart';
import 'package:dor_gen/src/utils/code_builder.dart';
import 'package:dor_gen/src/utils/const_string.dart';
import 'package:dor_gen/src/utils/errors.dart';
import 'package:dor_gen/src/utils/import_builder.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _dtoConfigChecker = TypeChecker.fromRuntime(DtoConfig);

class DtoGenerator extends GeneratorForAnnotation<Dto> {
  final ImportBuilder _importBuilder = ImportBuilder();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();

    //primary import
    _importBuilder.addToImports(CodeBuilder.standardIgnore());
    _importBuilder.addToImports('// DTO for ${element.name};');
    _importBuilder.addToImports(CodeBuilder.import('package:json_annotation/json_annotation.dart'));
    _importBuilder.addToImports(CodeBuilder.import(element.source!.shortName));
    _importBuilder.addAllImportsOfSourceFile(element);
    //build dto class
    final String dtoClassName = CodeBuilder.createDtoClassNameFromClassName(element.name ?? '');
    _buildDtoClass(
      buffer: buffer,
      inputClass: element,
      dtoClassName: dtoClassName,
      annotation: annotation,
    );

    //build extension mapper to domain
    if (annotation.read(ConstString.dtoConfigGenerateToDomain).boolValue) {
      _buildExtensionToDomain(
        buffer: buffer,
        inputClass: element,
        dtoClassName: dtoClassName,
      );
    }
    //build extension mapper to dto
    if (annotation.read(ConstString.dtoConfigGenerateToDto).boolValue) {
      _buildExtensionToDto(
        buffer: buffer,
        inputClass: element,
        dtoClassName: dtoClassName,
      );
    }

    //last import - part
    _importBuilder.addToImports(CodeBuilder.fromElementToGeneratedPart(element));

    //build result file
    StringBuffer result = StringBuffer();
    StringBuffer importBuffer = StringBuffer();
    _importBuilder.addImportsToBuffer(importBuffer);
    _importBuilder.clearImports();
    result.write(importBuffer);
    result.write(buffer);
    return result.toString();
  }

  void _addJsonSerializableAnnotation({
    required ConstantReader annotation,
    required StringBuffer buffer,
  }) {
    final DartObject jsonSerializable = annotation.read(ConstString.dtoConfigJsonSerializable).objectValue;
    buffer.writeln('@JsonSerializable(');
    buffer.writeln('  anyMap: ${jsonSerializable.getField('anyMap')?.toBoolValue()},');
    buffer.writeln('  checked: ${jsonSerializable.getField('checked')?.toBoolValue()},');
    buffer.writeln('  constructor: ${jsonSerializable.getField('constructor')?.toStringValue()},');
    buffer.writeln('  createFieldMap: ${jsonSerializable.getField('createFieldMap')?.toBoolValue()},');
    buffer.writeln(
        '  disallowUnrecognizedKeys: ${jsonSerializable.getField('disallowUnrecognizedKeys')?.toBoolValue()},');
    buffer.writeln('  explicitToJson: ${jsonSerializable.getField('explicitToJson')?.toBoolValue()},');
    if (jsonSerializable.getField('fieldRename') != null) {
      String fieldRename = '';
      fieldRename = jsonSerializable.getField('fieldRename')?.getField('_name')?.toStringValue() ?? '';
      if (fieldRename.isNotEmpty) {
        fieldRename = 'FieldRename.$fieldRename';
        buffer.writeln('  fieldRename: $fieldRename,');
      }
    }

    buffer.writeln('  ignoreUnannotated: ${jsonSerializable.getField('ignoreUnannotated')?.toBoolValue()},');
    buffer.writeln('  includeIfNull: ${jsonSerializable.getField('includeIfNull')?.toBoolValue()},');

    if (jsonSerializable.getField('converters')?.toListValue()?.isEmpty ?? false) {
      throw UnimplementedError('JsonSerializable converters not implemented yet');
      //TODO
      // buffer.writeln('  converters: ${jsonSerializable.getField('converters')?.toListValue()?.map((e) =>e. ).toList()},');
    }

    if (jsonSerializable.getField('createFactory')?.toBoolValue() != null ||
        jsonSerializable.getField('createToJson')?.toBoolValue() != null) {
      throw BadArgumentsError(
          'JsonSerializable createFactory or createToJson is not null. It is not allowed to use createFactory or createToJson in JsonSerializable. Use Dto  toDomain or toDto annotation instead.');
    }

    buffer.writeln(
        '  genericArgumentFactories: ${jsonSerializable.getField('genericArgumentFactories')?.toBoolValue()},');
    buffer.writeln('  createPerFieldToJson: ${jsonSerializable.getField('createPerFieldToJson')?.toBoolValue()},');
    buffer.writeln('  createToJson: ${annotation.read(ConstString.dtoConfigGenerateToDto).boolValue},');
    buffer.writeln('  createFactory: ${annotation.read(ConstString.dtoConfigGenerateToDomain).boolValue},');
    buffer.writeln(')');
  }

  void _buildClassField({
    required StringBuffer buffer,
    required List<Element> elements,
  }) {
    for (final field in elements) {
      if (field is FieldElement) {
        _addFieldDto(
          buffer: buffer,
          field: field,
        );
      }
    }
  }

  void _addFieldDto({
    required StringBuffer buffer,
    required FieldElement field,
  }) {
    final type = field.type;
    _importBuilder.recursionImportsOfDartTypes(type: type);
    _importBuilder.recursionImportsOfDtoDartTypes(type);
    String fieldType = '';

    if (!_importBuilder.checkIfIsNotOneOfDartCoreTypes(type)) {
      fieldType = '${type.element?.name}';
    } else if (type.element is EnumElement) {
      fieldType = '${type.element?.name}';
    } else {
      fieldType = '${type.element?.name ?? ''}Dto';
    }
    if (type.nullabilitySuffix == NullabilitySuffix.question) {
      fieldType += '?';
    }
    _FieldDto fieldDto = _FieldDto(name: fieldType, parameters: []);
    if (type is ParameterizedType) {
      for (var typeArgument in type.typeArguments) {
        _buildFieldTypeDtoRecursive(type: typeArgument, fieldDto: fieldDto);
      }
    }

    fieldType = fieldDto.toTypeString();

    final String jsonKeyAnnotation = _buildJsonKeyAnnotation(fieldElement: field);
    if (jsonKeyAnnotation.isNotEmpty) {
      buffer.writeln('  $jsonKeyAnnotation');
    }

    if (field.isFinal) {
      buffer.writeln('  final $fieldType ${field.name};');
    } else {
      buffer.writeln('  $fieldType ${field.name};');
    }
  }

  String? _defaultValueFieldDecode(DartObject jsonKey) {
    DartObject? defaultValue = jsonKey.getField('defaultValue');
    if (defaultValue != null) {
      if (defaultValue.isNull) {
        return 'null';
      } else if (defaultValue.toBoolValue() != null) {
        return defaultValue.toBoolValue().toString();
      } else if (defaultValue.toIntValue() != null) {
        return defaultValue.toIntValue().toString();
      } else if (defaultValue.toDoubleValue() != null) {
        return defaultValue.toDoubleValue().toString();
      } else if (defaultValue.toStringValue() != null) {
        return '\'${defaultValue.toStringValue()}\'';
      } else if (defaultValue.toTypeValue() != null) {
        return defaultValue.toTypeValue().toString();
      } else if (defaultValue.toListValue() != null) {
        //TODO
        throw UnimplementedError('defaultValue.toListValue() not implemented yet');
        // return defaultValue.toListValue().toString();
      } else if (defaultValue.toMapValue() != null) {
        //TODO
        throw UnimplementedError('defaultValue.toMapValue() not implemented yet');
      } else if (defaultValue.toSetValue() != null) {
        //TODO
        throw UnimplementedError('defaultValue.toSetValue() not implemented yet');
      } else if (defaultValue.toSymbolValue() != null) {
        //TODO
        throw UnimplementedError('defaultValue.toSymbolValue() not implemented yet');
      } else if (defaultValue.toFunctionValue() != null) {
        //TODO
        throw UnimplementedError('defaultValue.toFunctionValue() not implemented yet');
      } else {
        throw UnimplementedError('DefaultValue for that type is not implemented yet');
      }
    }
    return null;
  }

  String _buildJsonKeyAnnotation({required FieldElement fieldElement}) {
    String result = '';
    final jsonKey = _dtoConfigChecker.firstAnnotationOfExact(fieldElement)?.getField(ConstString.dtoConfigJsonKey);

    if (jsonKey != null) {
      result += '@JsonKey(';
      String? defaultValue = _defaultValueFieldDecode(jsonKey);
      if (defaultValue != null) {
        result += 'defaultValue: $defaultValue,';
      }

      result += 'disallowNullValue: ${jsonKey.getField('disallowNullValue')?.toBoolValue()},';

      result += _buildFunctionJsonKey(
        functionField: jsonKey.getField('fromJson'),
        fieldName: 'fromJson',
      );
      result += 'includeFromJson: ${jsonKey.getField('includeFromJson')?.toBoolValue()},';
      result += 'includeIfNull: ${jsonKey.getField('includeIfNull')?.toBoolValue()},';
      result += 'includeToJson: ${jsonKey.getField('includeToJson')?.toBoolValue()},';

      String? name = jsonKey.getField('name')?.toStringValue();
      if (name != null) {
        result += 'name: \'$name\',';
      }

      result += _buildFunctionJsonKey(
        functionField: jsonKey.getField('readValue'),
        fieldName: 'readValue',
      );
      result += 'required: ${jsonKey.getField('required')?.toBoolValue()},';
      result += _buildFunctionJsonKey(
        functionField: jsonKey.getField('toJson'),
        fieldName: 'toJson',
      );

      result += _buildUnknownEnumValue(jsonKey.getField('unknownEnumValue'));
      result += ')';
    }
    return result;
  }

  String _buildUnknownEnumValue(DartObject? unknownEnumValueField) {
    String result = '';
    if (unknownEnumValueField != null && unknownEnumValueField.variable != null) {
      if (unknownEnumValueField.variable?.name == 'nullForUndefinedEnumValue') {
        result += 'unknownEnumValue: JsonKey.${unknownEnumValueField.variable?.name},';
      } else {
        result +=
            'unknownEnumValue: ${unknownEnumValueField.type?.element?.name}.${unknownEnumValueField.variable?.name},';
      }
    }
    return result;
  }

  String _buildFunctionJsonKey({
    required DartObject? functionField,
    required String fieldName,
  }) {
    String result = '';
    final function = functionField?.toFunctionValue();
    if (function != null) {
      if (function.enclosingElement.name != null) {
        result += '$fieldName: ${function.enclosingElement.name}.${function.name},';
      } else {
        result += '$fieldName: ${function.name},';
      }
      _importBuilder.addImportsOfDartFunctionTypes(type: function.type);
    }
    return result;
  }

  void _buildFieldTypeDtoRecursive({
    required DartType type,
    required _FieldDto fieldDto,
  }) {
    String fieldType = '';
    if (!_importBuilder.checkIfIsNotOneOfDartCoreTypes(type)) {
      fieldType = type.element?.name ?? '';
    } else if (type.element is EnumElement) {
      fieldType = type.element?.name ?? '';
    } else {
      fieldType = '${type.element?.name ?? ''}Dto';
    }
    if (type.nullabilitySuffix == NullabilitySuffix.question) {
      fieldType += '?';
    }
    _FieldDto field = _FieldDto(name: fieldType, parameters: []);
    if (type is ParameterizedType) {
      for (var typeArgument in type.typeArguments) {
        _buildFieldTypeDtoRecursive(type: typeArgument, fieldDto: field);
      }
    }
    fieldDto.parameters.add(field);
  }

  void _buildClassConstructor({
    required StringBuffer buffer,
    required Element inputClass,
  }) {
    final constructor = inputClass.children.firstWhere((element) => element is ConstructorElement);
    constructor as ConstructorElement;
    if (constructor.isConst) {
      buffer.writeln('  const ${CodeBuilder.createDtoClassNameFromClassName(inputClass.name!)}({');
    } else {
      buffer.writeln('  ${CodeBuilder.createDtoClassNameFromClassName(inputClass.name!)}({');
    }
    for (final parameter in constructor.parameters) {
      if (!parameter.isNamed) {
        throw UnnamedParameterError(inputClass.name!);
      }
      if (parameter.isRequired) {
        buffer.writeln('    required this.${parameter.name},');
      } else {
        buffer.writeln('    this.${parameter.name},');
      }
    }

    buffer.writeln('  });');
  }

  void _buildToJsonFromJsonMethod({
    required StringBuffer buffer,
    required Element inputClass,
    required String dtoClassName,
  }) {
    buffer.writeln('  Map<String, dynamic> toJson() => _\$${dtoClassName}ToJson(this);');
    buffer.writeln('');
    buffer.writeln('  factory $dtoClassName.fromJson(Map<String, dynamic> json) => _\$${dtoClassName}FromJson(json);');
    buffer.writeln('');
  }

  void _buildDtoClass({
    required StringBuffer buffer,
    required Element inputClass,
    required String dtoClassName,
    required ConstantReader annotation,
  }) {
    _addJsonSerializableAnnotation(
      annotation: annotation,
      buffer: buffer,
    );
    buffer.writeln('class $dtoClassName {');
    _buildClassField(
      buffer: buffer,
      elements: inputClass.children,
    );
    buffer.writeln('');
    _buildClassConstructor(
      buffer: buffer,
      inputClass: inputClass,
    );
    buffer.writeln('');
    _buildToJsonFromJsonMethod(
      buffer: buffer,
      inputClass: inputClass,
      dtoClassName: dtoClassName,
    );

    buffer.write('}');
  }

  void _buildExtensionToDto({
    required StringBuffer buffer,
    required Element inputClass,
    required String dtoClassName,
  }) {
    buffer.writeln('');
    buffer.writeln('extension ${inputClass.name}To$dtoClassName on ${inputClass.name} {');
    buffer.writeln('  $dtoClassName toDto() =>');
    buffer.writeln('    $dtoClassName(');
    for (final field in inputClass.children) {
      if (field is FieldElement) {
        final type = field.type;
        String line = '';
        if (type.isDartCoreList) {
          line += '      ${field.name}: ${field.name}.map((e)=> ';
          line += _buildMappingForListToDto(type: (type as ParameterizedType).typeArguments.first);
          line += ').toList(growable:false),';
        } else if (type.element is EnumElement) {
          line += '      ${field.name}: ${field.name},';
        } else if (_importBuilder.checkIfIsNotOneOfDartCoreTypes(field.type)) {
          line += '      ${field.name}: ${field.name}.toDto(),';
        } else {
          line += '      ${field.name}: ${field.name},';
        }
        buffer.writeln(line);
      }
    }
    buffer.writeln('    );');
    buffer.writeln('  ');
    buffer.writeln('}');
  }

  String _buildMappingForListToDto({required DartType type}) {
    String result = '';
    if (type.isDartCoreList) {
      result += 'e.map((e)=>';
      result += _buildMappingForListToDto(type: (type as ParameterizedType).typeArguments.first);
      result += ').toList(growable:false)';
    } else if (type.element is EnumElement) {
      result += 'e';
    } else if (_importBuilder.checkIfIsNotOneOfDartCoreTypes(type)) {
      result += ' e.toDto()';
    } else {
      result += 'e';
    }
    return result;
  }

  String _buildMappingForListToDomain({required DartType type}) {
    String result = '';
    if (type.isDartCoreList) {
      result += 'e.map((e)=>';
      result += _buildMappingForListToDomain(type: (type as ParameterizedType).typeArguments.first);
      result += ').toList(growable:false)';
    } else if (type.element is EnumElement) {
      result += 'e';
    } else if (_importBuilder.checkIfIsNotOneOfDartCoreTypes(type)) {
      result += ' e.toDomain()';
    } else {
      result += 'e';
    }
    return result;
  }

  void _buildExtensionToDomain({
    required StringBuffer buffer,
    required Element inputClass,
    required String dtoClassName,
  }) {
    buffer.writeln('');
    buffer.writeln('extension ${dtoClassName}To${inputClass.name} on $dtoClassName {');
    buffer.writeln('  $dtoClassName toDomain() =>');
    buffer.writeln('    $dtoClassName(');
    for (final field in inputClass.children) {
      if (field is FieldElement) {
        final type = field.type;
        String line = '';
        if (type.isDartCoreList) {
          line += '      ${field.name}: ${field.name}.map((e)=> ';
          line += _buildMappingForListToDomain(type: (type as ParameterizedType).typeArguments.first);
          line += ').toList(growable:false),';
        } else if (type.element is EnumElement) {
          line += '      ${field.name}: ${field.name},';
        } else if (_importBuilder.checkIfIsNotOneOfDartCoreTypes(field.type)) {
          line += '      ${field.name}: ${field.name}.toDomain(),';
        } else {
          line += '      ${field.name}: ${field.name},';
        }
        buffer.writeln(line);
      }
    }
    buffer.writeln('    );');
    buffer.writeln('  ');
    buffer.writeln('}');
  }
}

class _FieldDto {
  final String name;
  final List<_FieldDto> parameters;

  _FieldDto({
    required this.name,
    required this.parameters,
  });

  String toTypeString() {
    String result = '';
    if (parameters.isEmpty) {
      result = name;
    } else {
      result += '$name<';
      for (var parameter in parameters) {
        result += _recursiveString(parameter);
      }
      result += '>';
    }
    return result;
  }

  String _recursiveString(_FieldDto fieldDto) {
    String typeName = '';
    if (fieldDto.parameters.isEmpty) {
      typeName += fieldDto.name;
    } else {
      typeName += '${fieldDto.name}<';
      for (var parameter in fieldDto.parameters) {
        typeName += _recursiveString(parameter);
      }
      typeName += '>';
    }
    return typeName;
  }

  @override
  String toString() {
    return 'FieldDto{name: $name, parameters: $parameters}';
  }
}
