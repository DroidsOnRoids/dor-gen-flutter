library dor_gen.builder;

import 'package:build/build.dart';
import 'package:dor_gen/src/generator/data_source_generator.dart';
import 'package:dor_gen/src/generator/dto_generator.dart';
import 'package:dor_gen/src/generator/repository_impl_generator.dart';
import 'package:dor_gen/src/generator/use_case_generator.dart';
import 'package:dor_gen/src/utils/const_string.dart';
import 'package:source_gen/source_gen.dart';

Builder useCasesBuilder(BuilderOptions options) => LibraryBuilder(
      UseCasesGenerator(),
      generatedExtension: '.use_cases.g.dart',
      header: ConstString.defaultDorHeader,
    );

Builder dtoBuilder(BuilderOptions options) => LibraryBuilder(
      DtoGenerator(),
      generatedExtension: '.dto.g.dart',
      header: ConstString.defaultDorHeader,
    );

Builder dataSourceBuilder(BuilderOptions options) => LibraryBuilder(
      DataSourceGenerator(),
      generatedExtension: '.data_source.g.dart',
      header: ConstString.defaultDorHeader,
    );

Builder repositoryImplBuilder(BuilderOptions options) => LibraryBuilder(
      RepositoryImplGenerator(),
      generatedExtension: '.impl.g.dart',
      header: ConstString.defaultDorHeader,
    );
