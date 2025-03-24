import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dor_gen/annotations.dart';
import 'package:dor_gen/src/utils/code_builder.dart';
import 'package:dor_gen/src/utils/const_string.dart';
import 'package:dor_gen/src/utils/errors.dart';
import 'package:dor_gen/src/utils/import_builder.dart';
import 'package:retrofit/retrofit.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _dorConfigChecker = TypeChecker.fromRuntime(DorConfig);
const TypeChecker _bodyChecker = TypeChecker.fromRuntime(Body);
const TypeChecker _queryChecker = TypeChecker.fromRuntime(Query);
const TypeChecker _pathParametersChecker = TypeChecker.fromRuntime(Path);

class DataSourceGenerator extends GeneratorForAnnotation<DorGenerator> {
  final ImportBuilder _importBuilder = ImportBuilder();

  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();
    //primary imports
    _importBuilder.addToImports(CodeBuilder.standardIgnore());
    _importBuilder.addToImports('// Data Source for ${element.name};');
    _addStandardImportForDataSource(element: element);

    if (_shouldGenerateDataSource(annotation)) {
      final String dataSourceClassName = CodeBuilder.createNameForDataSource(element);
      buffer.writeln('');
      _buildDataSourceClass(
        buffer: buffer,
        element: element,
        dataSourceClassName: dataSourceClassName,
      );
    }

    //last import - part
    _importBuilder.addToImports(CodeBuilder.fromElementToGeneratedPart(
      element: element,
      extension: ['data_source', 'g', 'g', 'dart'],
    ));

    //Put together imports and content
    StringBuffer result = StringBuffer();
    StringBuffer importBuffer = StringBuffer();
    _importBuilder.addImportsToBuffer(importBuffer);
    _importBuilder.clearImports();
    result.write(importBuffer);
    result.write(buffer);
    return result.toString();
  }

  _shouldGenerateDataSource(ConstantReader annotation) =>
      annotation.read(ConstString.dorGeneratorGenerateDataSource).boolValue;
  _addStandardImportForDataSource({
    required Element element,
  }) {
    _importBuilder.addToImports(CodeBuilder.import('package:dio/dio.dart'));
    _importBuilder.addToImports(CodeBuilder.import('package:injectable/injectable.dart'));
    _importBuilder.addToImports(CodeBuilder.import('package:retrofit/retrofit.dart'));
    _importBuilder.addToImports(CodeBuilder.import(element.source!.shortName));
  }

  _buildDataSourceClass({
    required StringBuffer buffer,
    required Element element,
    required String dataSourceClassName,
  }) {
    buffer.writeln('@LazySingleton()');
    buffer.writeln('@RestApi()');
    buffer.writeln('abstract class $dataSourceClassName {');
    buffer.writeln('@factoryMethod');
    buffer.writeln('factory $dataSourceClassName(Dio dio) = _$dataSourceClassName;');
    buffer.writeln('');

    for (var method in element.children) {
      if (method is MethodElement) {
        final dorConfig = _dorConfigChecker.firstAnnotationOfExact(method);
        if (dorConfig != null) {
          final generateDataSourceMethod =
              dorConfig.getField(ConstString.dorConfigGenerateDataSourceMethod)?.toBoolValue();
          if (generateDataSourceMethod ?? true) {
            final String? path = dorConfig.getField(ConstString.dorConfigPath)?.toStringValue();
            final String? apiMethod = dorConfig.getField(ConstString.dorConfigApiMethod)?.variable?.name;

            if (apiMethod != null && path != null) {
              _buildMethod(
                buffer: buffer,
                method: method,
                apiMethod: apiMethod,
                path: path,
              );
            } else {
              throw MissingArgumentError('Method ${method.name} is missing path or apiMethod in DorConfig annotation');
            }
          }
        } else {
          throw MissingArgumentError('Method ${method.name} is missing DorConfig annotation');
        }
      }
    }

    buffer.writeln('}');
  }

  _buildMethod({
    required StringBuffer buffer,
    required MethodElement method,
    required String apiMethod,
    required String path,
  }) {
    buffer.writeln('@$apiMethod(\'$path\')');
    buffer.writeln('${CodeBuilder.buildDtoTypeAndAddImports(
      importBuilder: _importBuilder,
      type: method.returnType,
    )} ${method.name}(');
    if (method.parameters.isNotEmpty) {
      buffer.write('{');
    }
    _buildMethodArguments(buffer: buffer, method: method);
    if (method.parameters.isNotEmpty) {
      buffer.write('}');
    }
    buffer.writeln(');');
    buffer.writeln('');
  }

  _buildMethodArguments({
    required StringBuffer buffer,
    required MethodElement method,
  }) {
    for (var parameter in method.parameters) {
      final body = _bodyChecker.hasAnnotationOfExact(parameter);
      final query = _queryChecker.hasAnnotationOfExact(parameter);
      final path = _pathParametersChecker.hasAnnotationOfExact(parameter);
      if (body) {
        buffer.write('@Body() ');
      } else if (query) {
        String? queryValue = _queryChecker.firstAnnotationOfExact(parameter)?.getField('value')?.toStringValue();
        buffer.write('@Query(');
        if (queryValue != null) {
          buffer.write('\'$queryValue\'');
        }
        buffer.write(') ');
      } else if (path) {
        String? pathParamValue =
            _pathParametersChecker.firstAnnotationOfExact(parameter)?.getField('value')?.toStringValue();
        buffer.write('@Path(');
        if (pathParamValue != null) {
          buffer.write('\'$pathParamValue\' ');
        }
        buffer.write(') ');
      }
      if (parameter.isRequired) {
        buffer.write('required ');
      }
      buffer.write('${CodeBuilder.buildDtoTypeAndAddImports(
        type: parameter.type,
        importBuilder: _importBuilder,
      )} ${parameter.name}');
      if (parameter.defaultValueCode != null) {
        buffer.write(' = ${parameter.defaultValueCode}');
      }
      buffer.writeln(',');
    }
  }
}
