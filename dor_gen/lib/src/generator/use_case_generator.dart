import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dor_gen/src/annotations/dor_config_annotation.dart';
import 'package:dor_gen/src/annotations/dor_generator_annotation.dart';
import 'package:dor_gen/src/utils/const_string.dart';
import 'package:dor_gen/src/utils/errors.dart';
import 'package:dor_gen/src/utils/formatters.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _DorConfigChecker = TypeChecker.fromRuntime(DorConfig);

class UseCasesGenerator extends GeneratorForAnnotation<DorGenerator> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    print('Start generator for ${element.name}');
    final buffer = StringBuffer();
    buffer.writeln('// UseCases for ${element.name};');

    if (_shouldGenerateUseCases(annotation)) {
      _imports(buffer: buffer, element: element);

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
    return buffer.toString();
  }

  void _imports({
    required StringBuffer buffer,
    required Element element,
  }) {
    buffer.writeln(Formatters.import('package:injectable/injectable.dart'));
    buffer.writeln(Formatters.import(element.source!.shortName));
    //TODO add imports for custom classes
    buffer.writeln('');
  }

  bool _shouldGenerateUseCases(ConstantReader annotation) =>
      annotation.read(ConstString.dorConfigGenerateUseCase).boolValue;

  bool _shouldGenerateUseCase(Element child) {
    final configAnnotation = _DorConfigChecker.firstAnnotationOfExact(child);
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
    final useCaseName = Formatters.createUseCaseNameFromMethod(method);
    final defineParameters = _buildDefineParametersList(method);
    final parameters = _buildParameters(method);
    buffer.writeln('@injectable');
    buffer.writeln('class $useCaseName {');
    buffer.writeln('  final ${element.name} _repository;');
    buffer.writeln('');
    buffer.writeln('  $useCaseName(this._repository);');
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

  String _buildDefineParametersList(MethodElement method) {
    String parameters = '';
    if (method.parameters.isNotEmpty) {
      for (final parameter in method.parameters) {
        if (!parameter.isNamed) {
          throw UnnamedParameterError(method.name);
        }

        print('siemaaa :${parameter.type.element?.source.toString()}');

        if (parameter.isRequired) {
          parameters += '''      required ${parameter.type} ${parameter.name},
''';
        } else {
          parameters += '''      ${parameter.type} ${parameter.name},
''';
        }
      }
    }
    return parameters;
  }

  String _buildParameters(MethodElement method) {
    String parameters = '';
    if (method.parameters.isNotEmpty) {
      for (final parameter in method.parameters) {
        parameters += '''      ${parameter.name}: ${parameter.name},
''';
      }
    }
    return parameters;
  }
}
