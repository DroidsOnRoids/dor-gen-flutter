import 'package:dor_gen/annotations.dart';
import 'package:example/domain/spam/model/cat.dart';
import 'package:example/domain/spam/model/egg.dart';
import 'package:example/domain/spam/model/plant.dart';
import 'package:retrofit/retrofit.dart';

@DorGenerator()
abstract class SpamRepository {
  @DorConfig(
    generateUseCase: true,
    apiMethod: ApiMethod.POST,
    path: '/api/v1/spam/doSomething',
  )
  Future<void> doSomething();

  @DorConfig(
    generateUseCase: true,
    generateDataSourceMethod: true,
    apiMethod: ApiMethod.GET,
    path: '/api/v1/spam/doSomethingElse',
  )
  Future<List<String>> doSomethingElse({
    @Body() required String param1,
    @Query('param2') int? param2,
    @Path('param3') required int param3,
    @Query('param4') int? param4,
    @Query('param5') int? param5,
    @Query('param6') int? param6,
  });

  @DorConfig(apiMethod: ApiMethod.POST, path: '/api/v1/spam/setEgg')
  Future<List<String>> setEgg({required Egg newEgg});

  @DorConfig(apiMethod: ApiMethod.POST, path: '/api/v1/spam/setEgg2')
  Future<void> setEgg2({required Egg newEgg});

  @DorConfig(apiMethod: ApiMethod.POST, path: '/api/v1/spam/setPlant')
  Future<void> setLotEggs({
    required List<Cat> newEggsFuture,
  });
  @DorConfig(apiMethod: ApiMethod.GET, path: '/api/v1/spam/getEgg')
  Future<Egg> getEgg();

  @DorConfig(apiMethod: ApiMethod.GET, path: '/api/v1/spam/getEgg2')
  Future<Egg> getEgg2();

  @DorConfig(apiMethod: ApiMethod.GET, path: '/api/v1/spam/getPlant')
  Future<Plant> getPlant();

  @DorConfig(
    apiMethod: ApiMethod.GET,
    path: '/api/v1/spam/getZombieWithCast',
  )
  Future<List<Cat>> getZombieWithCats();

  @DorConfig(
    apiMethod: ApiMethod.GET,
    path: '/api/v1/spam/getLotsZombiesWithCats',
  )
  Future<List<List<Cat>>> getLotsZombiesWithCats();
}
