// GENERATED CODE - DO NOT MODIFY BY HAND
//
//**************************************************************************
//*                                                                        *
//*      ⚡ This code was generated using DroidsOnRoids generator ⚡      *
//*                                                                        *
//**************************************************************************

// **************************************************************************
// UseCasesGenerator
// **************************************************************************

// ignore_for_file: unused_import

// UseCases for FooRepository;
import 'package:injectable/injectable.dart';
import 'foo_repository.dart';
import 'package:example/domain/foo/model/thing.dart';

@injectable
class DoSomethingUseCase {
  final FooRepository _repository;

  const DoSomethingUseCase(this._repository);

  Future<Thing> call({
    required String id,
    required String name,
  }) =>
      _repository.doSomething(
        id: id,
        name: name,
      );
}
