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

// UseCases for SpamRepository;
import 'package:injectable/injectable.dart';
import 'spam_repository.dart';
import 'package:example/domain/spam/model/egg.dart';
import 'package:example/domain/spam/model/zombie.dart';
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
  }) =>
      _repository.doSomethingElse(
        param1: param1,
        param2: param2,
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

  void call({
    required Future<List<Zombie<Cat>>> newEggsFuture,
  }) =>
      _repository.setLotEggs(
        newEggsFuture: newEggsFuture,
      );
}

@injectable
class GetEggUseCase {
  final SpamRepository _repository;

  const GetEggUseCase(this._repository);

  Egg call() => _repository.getEgg();
}

@injectable
class GetEgg2UseCase {
  final SpamRepository _repository;

  const GetEgg2UseCase(this._repository);

  Egg call() => _repository.getEgg2();
}

@injectable
class GetPlantUseCase {
  final SpamRepository _repository;

  const GetPlantUseCase(this._repository);

  Plant call() => _repository.getPlant();
}

@injectable
class GetZombieWithCastUseCase {
  final SpamRepository _repository;

  const GetZombieWithCastUseCase(this._repository);

  Zombie<Cat> call() => _repository.getZombieWithCast();
}

@injectable
class GetLotsZombiesWithCatsUseCase {
  final SpamRepository _repository;

  const GetLotsZombiesWithCatsUseCase(this._repository);

  Future<List<Zombie<List<Cat>>>> call() =>
      _repository.getLotsZombiesWithCats();
}
