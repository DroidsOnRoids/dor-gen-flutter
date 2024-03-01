import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dor_gen/src/utils/field_dto.dart';
import 'package:dor_gen/src/utils/import_builder.dart';

class CodeBuilder {
  static String import(String path) => 'import \'$path\';';

  static String fromSourceFullNameToPackageImport(String fullName) {
    String source = fullName;
    var splitSource = source.split('/');
    var positionToDelete = splitSource.indexOf('lib');
    if (positionToDelete != -1) {
      splitSource.removeAt(positionToDelete);
    }

    source = splitSource.join('/');
    if (source[0] == '/') {
      source = source.substring(1);
    }
    source = 'package:$source';
    return source;
  }

  static String fromElementToDataSourceImport(Element element) {
    String source = element.librarySource!.fullName;
    var splitSource = source.split('/');
    var positionToDelete = splitSource.indexOf('lib');
    if (positionToDelete != -1) {
      splitSource.removeAt(positionToDelete);
    }
    var splitFileName = splitSource.last.split('.');
    splitFileName.removeLast();
    splitFileName.addAll(['data_source', 'g', 'dart']);
    splitSource.last = splitFileName.join('.');

    source = splitSource.join('/');
    if (source[0] == '/') {
      source = source.substring(1);
    }
    source = 'import \'package:$source\';';
    return source;
  }

  static String fromSourceFullNameToPackageDtoImport(String fullName) {
    String source = fullName;
    var splitSource = source.split('/');
    var positionToDelete = splitSource.indexOf('lib');
    if (positionToDelete != -1) {
      splitSource.removeAt(positionToDelete);
    }
    var splitFileName = splitSource.last.split('.');
    splitFileName.removeLast();
    splitFileName.addAll(['dto', 'g', 'dart']);
    splitSource.last = splitFileName.join('.');

    source = splitSource.join('/');
    if (source[0] == '/') {
      source = source.substring(1);
    }
    source = 'package:$source';
    return source;
  }

  static String fromElementToGeneratedPart({
    required Element element,
    required List<String> extension,
  }) {
    String source = element.librarySource!.fullName;
    var splitSource = source.split('/');
    source = splitSource.last;
    splitSource = source.split('.');
    splitSource.removeLast();
    splitSource.addAll(extension);
    source = splitSource.join('.');
    source = 'part \'$source\';';
    return source;
  }

  static String toUpperFirstLetter(String text) => text.substring(0, 1).toUpperCase() + text.substring(1);

  static String createUseCaseNameFromMethod(MethodElement method) => '${toUpperFirstLetter(method.name)}UseCase';

  static String createDtoClassNameFromClassName(String className) => '${toUpperFirstLetter(className)}Dto';

  static String createFieldTypeDtoNameFromField(FieldElement field) {
    final String fieldTypeName = field.type.getDisplayString(withNullability: false);
    if (field.type.nullabilitySuffix == NullabilitySuffix.none) {
      return '${fieldTypeName}Dto';
    }
    return '${fieldTypeName}Dto?';
  }

  static String standardIgnore() => '// ignore_for_file: unused_import\n\n';

  static String createNameForDataSource(Element element) => '${toUpperFirstLetter(element.name!)}DataSource';

  static String createImplClassNameFromClassName(String className) => '${toUpperFirstLetter(className)}Impl';

  static String buildDtoTypeAndAddImports({
    required DartType type,
    required ImportBuilder importBuilder,
  }) {
    importBuilder.recursionImportsOfDartTypes(type: type);
    importBuilder.recursionImportsOfDtoDartTypes(type);
    String dtoType = '';

    if (!importBuilder.checkIfIsNotOneOfDartCoreTypes(type)) {
      if ((type.element?.name ?? '') != '') {
        dtoType = '${type.element?.name}';
      } else {
        dtoType = 'void';
      }
    } else if (type.element is EnumElement) {
      dtoType = '${type.element?.name}';
    } else {
      dtoType = '${type.element?.name ?? ''}Dto';
    }
    if (type.nullabilitySuffix == NullabilitySuffix.question) {
      dtoType += '?';
    }
    FieldDto fieldDto = FieldDto(name: dtoType, parameters: []);
    if (type is ParameterizedType) {
      for (var typeArgument in type.typeArguments) {
        _buildTypeDtoRecursive(
          type: typeArgument,
          fieldDto: fieldDto,
          importBuilder: importBuilder,
        );
      }
    }

    return fieldDto.toTypeString();
  }

  static void _buildTypeDtoRecursive({
    required DartType type,
    required FieldDto fieldDto,
    required ImportBuilder importBuilder,
  }) {
    String fieldType = '';
    if (!importBuilder.checkIfIsNotOneOfDartCoreTypes(type)) {
      if ((type.element?.name ?? '') != '') {
        fieldType = '${type.element?.name}';
      } else {
        fieldType = 'void';
      }
    } else if (type.element is EnumElement) {
      fieldType = type.element?.name ?? '';
    } else {
      fieldType = '${type.element?.name ?? ''}Dto';
    }
    if (type.nullabilitySuffix == NullabilitySuffix.question) {
      fieldType += '?';
    }
    FieldDto field = FieldDto(name: fieldType, parameters: []);
    if (type is ParameterizedType) {
      for (var typeArgument in type.typeArguments) {
        _buildTypeDtoRecursive(
          type: typeArgument,
          fieldDto: field,
          importBuilder: importBuilder,
        );
      }
    }
    fieldDto.parameters.add(field);
  }
}
