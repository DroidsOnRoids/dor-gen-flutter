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

// Repository implementations for FooRepository;
import 'foo_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:example/domain/foo/repository/foo_repository.data_source.g.dart';
import 'package:example/domain/foo/model/thing.dart';
import 'package:example/domain/foo/model/thing.dto.g.dart';

@LazySingleton(as: FooRepository)
class FooRepositoryImpl implements FooRepository {
  final FooRepositoryDataSource _dataSource;

  const FooRepositoryImpl(this._dataSource);

  @override
  Future<Thing> doSomething({
    required String id,
    required String name,
  }) async {
    final resultDto = await _dataSource.doSomething(
      id: id,
      name: name,
    );
    final result = resultDto.toDomain();
    return result;
  }
}
