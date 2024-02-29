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

// Data Source for SpamRepository;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'spam_repository.dart';
import 'package:dor_gen/annotations.dart';
import 'package:example/domain/spam/model/cat.dart';
import 'package:example/domain/spam/model/egg.dart';
import 'package:example/domain/spam/model/plant.dart';
import 'package:example/domain/spam/model/zombie.dart';
part 'spam_repository.data_source.g.g.dart';

@LazySingleton()
@RestApi()
abstract class SpamRepositoryDataSource {
  @factoryMethod
  factory SpamRepositoryDataSource(Dio dio) = _SpamRepositoryDataSource;

  @POST('/api/v1/spam/doSomething')
  Future<void> doSomething();

  @GET('/api/v1/spam/doSomethingElse')
  Future<List<String>> doSomethingElse(
    @Body() String param1,
    @Query('param2') int? param2,
    @Path('param3') int param3,
    @Query('param4') int? param4,
    @Query('param5') int? param5,
    @Query('param6') int? param6,
  );
}
