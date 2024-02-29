import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

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
}
