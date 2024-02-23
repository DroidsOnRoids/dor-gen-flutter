import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dor_gen/src/annotations/dto.dart';
import 'package:dor_gen/src/utils/code_builder.dart';
import 'package:dor_gen/src/utils/const_string.dart';
import 'package:dor_gen/src/utils/errors.dart';
import 'package:dor_gen/src/utils/import_builder.dart';
import 'package:source_gen/source_gen.dart';

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

    //build dto class
    final String dtoClassName = CodeBuilder.createDtoClassNameFromClassName(element.name ?? '');
    _buildDtoClass(
      buffer: buffer,
      inputClass: element,
      dtoClassName: dtoClassName,
      annotation: annotation,
    );

    //build extension mapper to domain

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
    buffer.writeln('@JsonSerializable(');
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
        _importBuilder.recursionImportsOfDartTypes(type: field.type);
        _importBuilder.recursionImportsOfDtoDartTypes(field.type);
        String fieldType = '';
        if (!_importBuilder.checkIfIsNotOneOfDartCoreTypes(field.type)) {
          fieldType = field.type.getDisplayString(withNullability: true);
        } else {
          fieldType = CodeBuilder.createFieldTypeDtoNameFromField(field);
        }

        if (field.isFinal) {
          buffer.writeln('  final $fieldType ${field.name};');
        } else {
          buffer.writeln('  $fieldType ${field.name};');
        }
      }
    }
  }

  String _buildFieldTypeDtoRecursive({
    required DartType type,
  }) {
    //TODO not that easy
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
        if (_importBuilder.checkIfIsNotOneOfDartCoreTypes(field.type)) {
          buffer.writeln('      ${field.name}: ${field.name}.toDto(),');
        } else {
          buffer.writeln('      ${field.name}: ${field.name},');
        }
      }
    }
    buffer.writeln('    );');
    buffer.writeln('  ');
    buffer.writeln('}');
  }
}
