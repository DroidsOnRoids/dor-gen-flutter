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

// UseCases for SpamRepository;
import 'package:injectable/injectable.dart';
import 'spam_repository.dart';

@injectable
class DoSomethingUseCase {
  final SpamRepository _repository;

  DoSomethingUseCase(this._repository);

  Future<void> call() => _repository.doSomething();
}

@injectable
class DoSomethingElseUseCase {
  final SpamRepository _repository;

  DoSomethingElseUseCase(this._repository);

  Future<List<String>> call({
    required String param1,
    int? param2,
  }) =>
      _repository.doSomethingElse(
        param1: param1,
        param2: param2,
      );
}

@injectable
class SetEggUseCase {
  final SpamRepository _repository;

  SetEggUseCase(this._repository);

  void call({
    required Egg newEgg,
  }) =>
      _repository.setEgg(
        newEgg: newEgg,
      );
}
