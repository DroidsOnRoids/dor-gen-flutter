library dor_gen.builder;

import 'package:build/build.dart';
import 'package:dor_gen/src/generator/use_case_generator.dart';
import 'package:dor_gen/src/utils/const_string.dart';
import 'package:source_gen/source_gen.dart';

Builder useCasesBuilder(BuilderOptions options) => LibraryBuilder(
      UseCasesGenerator(),
      generatedExtension: '.use_case.g.dart',
      header: ConstString.defaultDorHeader,
    );
