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

// UseCases for SpamRepository;
import 'package:injectable/injectable.dart';
import 'spam_repository.dart';
import 'package:example/domain/spam/model/egg.dart';
import 'package:example/domain/spam/model/cat.dart';
import 'package:example/domain/spam/model/plant.dart';

@injectable
class DoSomethingUseCase {
  final SpamRepository _repository;

  const DoSomethingUseCase(this._repository);

  Future<void> call() => _repository.doSomething();
}

@injectable
class DoSomethingElseUseCase {
  final SpamRepository _repository;

  const DoSomethingElseUseCase(this._repository);

  Future<List<String>> call({
    required String param1,
    int? param2,
    required int param3,
    int? param4,
    int? param5,
    int? param6,
  }) =>
      _repository.doSomethingElse(
        param1: param1,
        param2: param2,
        param3: param3,
        param4: param4,
        param5: param5,
        param6: param6,
      );
}

@injectable
class SetEggUseCase {
  final SpamRepository _repository;

  const SetEggUseCase(this._repository);

  Future<List<String>> call({
    required Egg newEgg,
  }) =>
      _repository.setEgg(
        newEgg: newEgg,
      );
}

@injectable
class SetEgg2UseCase {
  final SpamRepository _repository;

  const SetEgg2UseCase(this._repository);

  Future<void> call({
    required Egg newEgg,
  }) =>
      _repository.setEgg2(
        newEgg: newEgg,
      );
}

@injectable
class SetLotEggsUseCase {
  final SpamRepository _repository;

  const SetLotEggsUseCase(this._repository);

  Future<void> call({
    required List<Cat> newEggsFuture,
  }) =>
      _repository.setLotEggs(
        newEggsFuture: newEggsFuture,
      );
}

@injectable
class GetEggUseCase {
  final SpamRepository _repository;

  const GetEggUseCase(this._repository);

  Future<Egg> call() => _repository.getEgg();
}

@injectable
class GetEgg2UseCase {
  final SpamRepository _repository;

  const GetEgg2UseCase(this._repository);

  Future<Egg> call() => _repository.getEgg2();
}

@injectable
class GetPlantUseCase {
  final SpamRepository _repository;

  const GetPlantUseCase(this._repository);

  Future<Plant> call() => _repository.getPlant();
}

@injectable
class GetZombieWithCatsUseCase {
  final SpamRepository _repository;

  const GetZombieWithCatsUseCase(this._repository);

  Future<List<Cat>> call() => _repository.getZombieWithCats();
}

@injectable
class GetLotsZombiesWithCatsUseCase {
  final SpamRepository _repository;

  const GetLotsZombiesWithCatsUseCase(this._repository);

  Future<List<Cat>> call() => _repository.getLotsZombiesWithCats();
}
