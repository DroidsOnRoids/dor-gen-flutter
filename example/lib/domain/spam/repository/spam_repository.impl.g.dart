// GENERATED CODE - DO NOT MODIFY BY HAND
//
//**************************************************************************
//*                                                                        *
//*      ⚡ This code was generated using DroidsOnRoids generator ⚡      *
//*                                                                        *
//**************************************************************************

// **************************************************************************
// RepositoryImplGenerator
// **************************************************************************

// ignore_for_file: unused_import

// Repository implementations for SpamRepository;
import 'spam_repository.dart';
import 'package:dor_gen/annotations.dart';
import 'package:example/domain/spam/model/cat.dart';
import 'package:example/domain/spam/model/egg.dart';
import 'package:example/domain/spam/model/plant.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import 'package:example/domain/spam/repository/spam_repository.data_source.g.dart';
import 'package:example/domain/spam/model/egg.dto.g.dart';
import 'package:example/domain/spam/model/plant.dto.g.dart';
import 'package:example/domain/spam/model/cat.dto.g.dart';

@LazySingleton(as: SpamRepository)
class SpamRepositoryImpl implements SpamRepository {
  final SpamRepositoryDataSource _dataSource;

  const SpamRepositoryImpl(this._dataSource);

  @override
  Future<void> doSomething() async {
    final resultDto = await _dataSource.doSomething();
    final result = resultDto;
    return result;
  }

  @override
  Future<List<String>> doSomethingElse({
    required String param1,
    int? param2,
    required int param3,
    int? param4,
    int? param5,
    int? param6,
  }) async {
    final resultDto = await _dataSource.doSomethingElse(
      param1: param1,
      param2: param2,
      param3: param3,
      param4: param4,
      param5: param5,
      param6: param6,
    );
    final result = resultDto.map((e) => e).toList(growable: false);
    return result;
  }

  @override
  Future<List<String>> setEgg({
    required Egg newEgg,
  }) async {
    final resultDto = await _dataSource.setEgg(
      newEgg: newEgg,
    );
    final result = resultDto.map((e) => e).toList(growable: false);
    return result;
  }

  @override
  Future<void> setEgg2({
    required Egg newEgg,
  }) async {
    final resultDto = await _dataSource.setEgg2(
      newEgg: newEgg,
    );
    final result = resultDto;
    return result;
  }

  @override
  Future<void> setLotEggs({
    required Future<List<Cat>> newEggsFuture,
  }) async {
    final resultDto = await _dataSource.setLotEggs(
      newEggsFuture: newEggsFuture,
    );
    final result = resultDto;
    return result;
  }

  @override
  Future<Egg> getEgg() async {
    final resultDto = await _dataSource.getEgg();
    final result = resultDto.toDomain();
    return result;
  }

  @override
  Future<Egg> getEgg2() async {
    final resultDto = await _dataSource.getEgg2();
    final result = resultDto.toDomain();
    return result;
  }

  @override
  Future<Plant> getPlant() async {
    final resultDto = await _dataSource.getPlant();
    final result = resultDto.toDomain();
    return result;
  }

  @override
  Future<List<Cat>> getZombieWithCats() async {
    final resultDto = await _dataSource.getZombieWithCats();
    final result = resultDto.map((e) => e.toDomain()).toList(growable: false);
    return result;
  }

  @override
  Future<List<List<Cat>>> getLotsZombiesWithCats() async {
    final resultDto = await _dataSource.getLotsZombiesWithCats();
    final result = resultDto
        .map((e) => e.map((e) => e.toDomain()).toList(growable: false))
        .toList(growable: false);
    return result;
  }
}
