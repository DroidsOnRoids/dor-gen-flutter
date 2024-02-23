import 'package:analyzer/dart/element/element.dart';

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

  static String toUpperFirstLetter(String text) => text.substring(0, 1).toUpperCase() + text.substring(1);
  static String createUseCaseNameFromMethod(MethodElement method) => '${toUpperFirstLetter(method.name)}UseCase';
}
