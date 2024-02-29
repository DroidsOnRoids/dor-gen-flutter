// GENERATED CODE - DO NOT MODIFY BY HAND
//
//**************************************************************************
//*                                                                        *
//*      ⚡ This code was generated using DroidsOnRoids generator ⚡      *
//*                                                                        *
//**************************************************************************

// **************************************************************************
// DataSourceGenerator
// **************************************************************************

// ignore_for_file: unused_import

// Data Source for FooRepository;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'foo_repository.dart';
import 'package:dor_gen/annotations.dart';
part 'foo_repository.data_source.g.g.dart';

@LazySingleton()
@RestApi()
abstract class FooRepositoryDataSource {
  @factoryMethod
  factory FooRepositoryDataSource(Dio dio) = _FooRepositoryDataSource;

  @POST('/api/v1/foo/doNothing')
  Future<void> doNothing();
}
