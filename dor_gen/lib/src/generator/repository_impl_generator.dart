import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dor_gen/annotations.dart';
import 'package:dor_gen/src/utils/code_builder.dart';
import 'package:dor_gen/src/utils/const_string.dart';
import 'package:dor_gen/src/utils/errors.dart';
import 'package:dor_gen/src/utils/import_builder.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _dorConfigChecker = TypeChecker.fromRuntime(DorConfig);

class RepositoryImplGenerator extends GeneratorForAnnotation<DorGenerator> {
  final ImportBuilder _importBuilder = ImportBuilder();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();
    //primary imports
    _importBuilder.addToImports(CodeBuilder.standardIgnore());
    _importBuilder.addToImports('// Repository implementations for ${element.name};');
    _importBuilder.addToImports(CodeBuilder.import(element.source!.shortName));
    _importBuilder.addAllImportsOfSourceFile(element);
    _importBuilder.addToImports(CodeBuilder.import('package:injectable/injectable.dart'));
    _importBuilder.addToImports(CodeBuilder.fromElementToDataSourceImport(element));

    if (annotation.read(ConstString.dorGeneratorGenerateRepositoryImpl).boolValue) {
      final String implClassName = CodeBuilder.createImplClassNameFromClassName(element.name ?? '');
      _buildImplClass(
        buffer: buffer,
        element: element,
        implClassName: implClassName,
      );
    }

    //Put together imports and content
    StringBuffer result = StringBuffer();
    StringBuffer importBuffer = StringBuffer();
    _importBuilder.addImportsToBuffer(importBuffer);
    _importBuilder.clearImports();
    result.write(importBuffer);
    result.write(buffer);
    return result.toString();
  }

  _buildImplClass({
    required StringBuffer buffer,
    required Element element,
    required String implClassName,
  }) {
    final String dataSourceClassName = CodeBuilder.createNameForDataSource(element);
    buffer.writeln('@LazySingleton(as: ${element.name})');
    buffer.writeln('class $implClassName implements ${element.name} {');
    buffer.writeln('  final $dataSourceClassName _dataSource;');
    buffer.writeln('');
    buffer.writeln('  const $implClassName(this._dataSource);');
    buffer.writeln('');
    for (final method in element.children) {
      if (method is MethodElement) {
        _buildMethod(buffer, method);
      }
    }
    buffer.writeln('}');
  }

  _buildMethod(
    StringBuffer buffer,
    MethodElement method,
  ) {
    final isAsync = method.returnType.isDartAsyncFuture;
    buffer.writeln('  @override');

    buffer.writeln('  ${method.returnType} ${method.name}(');
    _buildArguments(buffer: buffer, parameters: method.parameters);
    if (isAsync) {
      buffer.writeln('  ) async {');
    } else {
      buffer.writeln('  ) {');
    }

    _buildMethodBody(
      buffer: buffer,
      method: method,
      isAsync: isAsync,
    );
    buffer.writeln('  }');
    buffer.writeln('');
  }

  void _buildMethodBody({
    required StringBuffer buffer,
    required MethodElement method,
    required bool isAsync,
  }) {
    if (isAsync) {
      buffer.writeln('    final resultDto = await _dataSource.${method.name}(');
    } else {
      buffer.writeln('    final resultDto = _dataSource.${method.name}(');
    }

    for (var parameter in method.parameters) {
      buffer.writeln('      ${parameter.name}: ${parameter.name},');
    }
    buffer.writeln('    );');

    _buildReturnFromMethod(
      buffer: buffer,
      method: method,
    );
  }

  void _buildReturnFromMethod({
    required StringBuffer buffer,
    required MethodElement method,
  }) {
    final type = method.returnType;
    _importBuilder.recursionImportsOfDartTypes(type: type);
    _importBuilder.recursionImportsOfDtoDartTypes(type);
    buffer.writeln('    final result =');
    buffer.write(' resultDto');
    String line = '';
    if (type.isDartCoreList) {
      line += '.map((e)=> ';
      line += _buildMappingForListToDomain(
        type: (type as ParameterizedType).typeArguments.first,
        parentType: type,
      );
      line += ').toList(growable:false)';
    } else if (type.element is EnumElement) {
      line += '';
    } else if (_importBuilder.checkIfIsNotOneOfDartCoreTypes(type)) {
      line += '.toDomain()';
    } else if (type is ParameterizedType) {
      if (type.typeArguments.isNotEmpty) {
        line += _buildMappingForListToDomain(
          type: type.typeArguments.first,
          parentType: type,
        );
      }
    } else {
      line += '';
    }
    buffer.write(line);

    buffer.write(';');

    buffer.writeln('    return result;');
  }

  void _buildArguments({
    required StringBuffer buffer,
    required List<ParameterElement> parameters,
  }) {
    if (parameters.isNotEmpty) {
      buffer.write('{');
      for (var parameter in parameters) {
        if (!parameter.isNamed) {
          throw UnnamedParameterError('Parameter ${parameter.name} is not named. Please name all parameters.');
        }
        if (parameter.isRequired) {
          buffer.writeln('    required ${parameter.type} ${parameter.name},');
        } else {
          buffer.writeln('    ${parameter.type} ${parameter.name},');
        }
      }
      buffer.write('}');
    }
  }

  String _buildMappingForListToDomain({
    required DartType type,
    required DartType parentType,
  }) {
    String result = '';
    if (type.isDartCoreList) {
      if (parentType.isDartCoreList) {
        result += 'e.map((e)=>';
      } else {
        result += '.map((e)=>';
      }
      result += _buildMappingForListToDomain(type: (type as ParameterizedType).typeArguments.first, parentType: type);
      result += ').toList(growable:false)';
    } else if (type.element is EnumElement) {
      if (parentType.isDartCoreList) {
        result += 'e';
      } else {
        result += '';
      }
    } else if (_importBuilder.checkIfIsNotOneOfDartCoreTypes(type)) {
      if (parentType.isDartCoreList) {
        result += 'e.toDomain()';
      } else {
        result += '.toDomain()';
      }
    } else if (type is ParameterizedType) {
      if (type.typeArguments.isNotEmpty) {
        result += _buildMappingForListToDomain(
          type: type.typeArguments.first,
          parentType: type,
        );
      } else {
        if (parentType.isDartCoreList) {
          result += 'e';
        } else {
          result += '';
        }
      }
    } else {
      if (parentType.isDartCoreList) {
        result += 'e';
      } else {
        result += '';
      }
    }
    return result;
  }
}
