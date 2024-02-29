import 'package:dor_gen/annotations.dart';
import 'package:example/domain/spam/model/cat.dart';
import 'package:example/domain/spam/model/egg.dart';
import 'package:example/domain/spam/model/plant.dart';
import 'package:example/domain/spam/model/zombie.dart';
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

  @DorConfig(
    generateUseCase: false,
    generateDataSourceMethod: false,
  )
  void doNothing();

  @DorConfig(generateDataSourceMethod: false)
  Future<List<String>> setEgg({required Egg newEgg});

  @DorConfig(generateDataSourceMethod: false)
  Future<void> setEgg2({required Egg newEgg});

  @DorConfig(generateDataSourceMethod: false)
  void setLotEggs({
    required Future<List<Zombie<Cat>>> newEggsFuture,
  });

  @DorConfig(generateDataSourceMethod: false)
  Egg getEgg();

  @DorConfig(generateDataSourceMethod: false)
  Egg getEgg2();

  @DorConfig(generateDataSourceMethod: false)
  Plant getPlant();

  @DorConfig(generateDataSourceMethod: false)
  Zombie<Cat> getZombieWithCast();

  @DorConfig(generateDataSourceMethod: false)
  Future<List<Zombie<List<Cat>>>> getLotsZombiesWithCats();
}
