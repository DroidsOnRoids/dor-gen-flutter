import 'package:dor_gen/annotations.dart';
import 'package:example/domain/spam/model/cat.dart';
import 'package:example/domain/spam/model/egg.dart';
import 'package:example/domain/spam/model/plant.dart';
import 'package:example/domain/spam/model/zombie.dart';

@DorGenerator()
abstract class SpamRepository {
  Future<void> doSomething();

  @DorConfig(generateUseCase: true)
  Future<List<String>> doSomethingElse({
    required String param1,
    int? param2,
  });

  @DorConfig(generateUseCase: false)
  void doNothing();

  Future<List<String>> setEgg({required Egg newEgg});
  Future<void> setEgg2({required Egg newEgg});

  void setLotEggs({
    required Future<List<Zombie<Cat>>> newEggsFuture,
  });

  Egg getEgg();
  Egg getEgg2();

  Plant getPlant();

  Zombie<Cat> getZombieWithCast();

  Future<List<Zombie<List<Cat>>>> getLotsZombiesWithCats();
}
