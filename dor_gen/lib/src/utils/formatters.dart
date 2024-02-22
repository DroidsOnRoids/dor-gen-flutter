import 'package:analyzer/dart/element/element.dart';

class Formatters {
  static String import(String path) => 'import \'$path\';';
  static String toUpperFirstLetter(String text) => text.substring(0, 1).toUpperCase() + text.substring(1);
  static String createUseCaseNameFromMethod(MethodElement method) => '${toUpperFirstLetter(method.name)}UseCase';
}
