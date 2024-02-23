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

  void _addImportFromType({required DartType type}) {
    if (_checkIfIsOneOfDartCoreTypes(type)) {
      if (type.element?.librarySource != null) {
        String source = CodeBuilder.fromSourceFullNameToPackageImport(type.element!.source!.fullName);
        addToImports(CodeBuilder.import(source));
      }
    }
  }

  bool _checkIfIsOneOfDartCoreTypes(DartType type) => !(type.isDartCoreBool ||
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
      type.isDartAsyncFuture);

  void addImportsToBuffer(StringBuffer buffer) {
    for (var import in _imports) {
      buffer.writeln(import);
    }
  }

  void clearImports() {
    _imports.clear();
  }
}
