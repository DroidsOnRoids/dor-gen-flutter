import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dor_gen/src/utils/code_builder.dart';

class ImportBuilder {
  final List<String> _imports = [];

  void addToImports(String import) {
    if (!_imports.contains(import)) {
      _imports.add(import);
    }
  }

  void recursionImportsOfDartTypes({required DartType type}) {
    _addImportFromType(
      type: type,
    );
    if (type is ParameterizedType) {
      for (var typeArgument in type.typeArguments) {
        recursionImportsOfDartTypes(type: typeArgument);
      }
    }
  }

  void addImportsOfDartFunctionTypes({required FunctionType type}) {
    for (var parameter in type.parameters) {
      recursionImportsOfDartTypes(type: parameter.type);
    }
    recursionImportsOfDartTypes(type: type.returnType);
  }

  void _addImportFromType({required DartType type}) {
    if (checkIfIsNotOneOfDartCoreTypes(type)) {
      if (type.element?.librarySource != null) {
        String source = CodeBuilder.fromSourceFullNameToPackageImport(type.element!.source!.fullName);
        addToImports(CodeBuilder.import(source));
      }
    }
  }

  bool checkIfIsNotOneOfDartCoreTypes(DartType type) => !(type.isDartCoreBool ||
      type.isDartCoreDouble ||
      type.isDartCoreEnum ||
      type.isDartCoreFunction ||
      type.isDartCoreInt ||
      type.isDartCoreIterable ||
      type.isDartCoreList ||
      type.isDartCoreMap ||
      type.isDartCoreNull ||
      type.isDartCoreNum ||
      type.isDartCoreObject ||
      type.isDartCoreRecord ||
      type.isDartCoreSet ||
      type.isDartCoreString ||
      type.isDartCoreSymbol ||
      type.isDartCoreType ||
      type.isDartAsyncFuture ||
      type.toString() == 'DateTime' ||
      type.toString() == 'dynamic' ||
      type.toString() == 'void');

  void addImportsToBuffer(StringBuffer buffer) {
    for (var import in _imports) {
      buffer.writeln(import);
    }
  }

  void clearImports() {
    _imports.clear();
  }

  void recursionImportsOfDtoDartTypes(DartType type) {
    _addImportDtoFromType(type);
    if (type is ParameterizedType) {
      for (var typeArgument in type.typeArguments) {
        recursionImportsOfDtoDartTypes(typeArgument);
      }
    }
  }

  void _addImportDtoFromType(DartType type) {
    if (checkIfIsNotOneOfDartCoreTypes(type) && (type.element is! EnumElement)) {
      if (type.element?.librarySource != null) {
        String source = CodeBuilder.fromSourceFullNameToPackageDtoImport(type.element!.source!.fullName);
        addToImports(CodeBuilder.import(source));
      }
    }
  }
}
