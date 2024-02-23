import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dor_gen/src/annotations/dor_config_annotation.dart';
import 'package:dor_gen/src/annotations/dor_generator_annotation.dart';
import 'package:dor_gen/src/utils/code_builder.dart';
import 'package:dor_gen/src/utils/const_string.dart';
import 'package:dor_gen/src/utils/errors.dart';
import 'package:dor_gen/src/utils/import_builder.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _dorConfigChecker = TypeChecker.fromRuntime(DorConfig);

class UseCasesGenerator extends GeneratorForAnnotation<DorGenerator> {
  final ImportBuilder _importBuilder = ImportBuilder();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();

    _importBuilder.addToImports('// UseCases for ${element.name};');

    if (_shouldGenerateUseCases(annotation)) {
      _addStandardImportForUseCases(element: element);

      //generate use cases
      for (final method in element.children) {
        if (method is MethodElement && _shouldGenerateUseCase(method)) {
          _generateUseCase(
            buffer: buffer,
            method: method,
            element: element,
          );
        }
      }
    }

    StringBuffer result = StringBuffer();
    StringBuffer importBuffer = StringBuffer();
    _importBuilder.addImportsToBuffer(importBuffer);
    _importBuilder.clearImports();
    result.write(importBuffer);
    result.write(buffer);
    return result.toString();
  }

  void _addStandardImportForUseCases({
    required Element element,
  }) {
    _importBuilder.addToImports(CodeBuilder.import('package:injectable/injectable.dart'));
    _importBuilder.addToImports(CodeBuilder.import(element.source!.shortName));
  }

  bool _shouldGenerateUseCases(ConstantReader annotation) =>
      annotation.read(ConstString.dorConfigGenerateUseCase).boolValue;

  bool _shouldGenerateUseCase(Element child) {
    final configAnnotation = _dorConfigChecker.firstAnnotationOfExact(child);
    if (configAnnotation == null) {
      return true;
    }
    return configAnnotation.getField(ConstString.dorConfigGenerateUseCase)?.toBoolValue() ?? true;
  }

  void _generateUseCase({
    required StringBuffer buffer,
    required MethodElement method,
    required Element element,
  }) {
    final useCaseName = CodeBuilder.createUseCaseNameFromMethod(method);
    final defineParameters = _buildDefineParametersListAndAddImportOfParametersType(method: method);
    final parameters = _buildParametersAsArguments(method);
    _importBuilder.recursionImportsOfDartTypes(type: method.returnType);

    buffer.writeln('@injectable');
    buffer.writeln('class $useCaseName {');
    buffer.writeln('  final ${element.name} _repository;');
    buffer.writeln('');
    buffer.writeln('  const $useCaseName(this._repository);');
    buffer.writeln('');
    buffer.writeln(' ${method.returnType} call(');
    if (defineParameters.isNotEmpty) {
      buffer.writeln(' {');
      buffer.writeln('    $defineParameters');
      buffer.writeln(' }');
    }
    buffer.writeln(' ) =>');
    buffer.writeln('    _repository.${method.name}(');
    if (parameters.isNotEmpty) {
      buffer.writeln('    $parameters');
    }
    buffer.writeln('    );');
    buffer.writeln('}');
  }

  String _buildDefineParametersListAndAddImportOfParametersType({required MethodElement method}) {
    String parameters = '';
    if (method.parameters.isNotEmpty) {
      for (final parameter in method.parameters) {
        if (!parameter.isNamed) {
          throw UnnamedParameterError(method.name);
        }
        _importBuilder.recursionImportsOfDartTypes(type: parameter.type);

        if (parameter.isRequired) {
          parameters += '      required ${parameter.type} ${parameter.name},${ConstString.newline}';
        } else {
          parameters += '      ${parameter.type} ${parameter.name},${ConstString.newline}';
        }
      }
    }
    return parameters;
  }

  String _buildParametersAsArguments(MethodElement method) {
    String parameters = '';
    if (method.parameters.isNotEmpty) {
      for (final parameter in method.parameters) {
        parameters += '      ${parameter.name}: ${parameter.name},${ConstString.newline}';
      }
    }
    return parameters;
  }
}
