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
import 'package:dor_gen/annotations.dart';
import 'package:injectable/injectable.dart';
import 'package:example/domain/foo/repository/foo_repository.data_source.g.dart';

@LazySingleton(as: FooRepository)
class FooRepositoryImpl implements FooRepository {
  final FooRepositoryDataSource _dataSource;

  const FooRepositoryImpl(this._dataSource);

  @override
  Future<void> doNothing() async {
    final resultDto = await _dataSource.doNothing();
    final result = resultDto;
    return result;
  }
}
