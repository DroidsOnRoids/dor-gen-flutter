// GENERATED CODE - DO NOT MODIFY BY HAND
//
//**************************************************************************
//*                                                                        *
//*         This code was generated using DroidsOnRoids generator          *
//*                                                                        *
//**************************************************************************

// **************************************************************************
// UseCasesGenerator
// **************************************************************************

// ignore_for_file: unused_import

// UseCases for FooRepository;
import 'package:injectable/injectable.dart';
import 'foo_repository.dart';

@injectable
class DoNothingUseCase {
  final FooRepository _repository;

  const DoNothingUseCase(this._repository);

  void call() => _repository.doNothing();
}
