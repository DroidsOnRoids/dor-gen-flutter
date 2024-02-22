import 'package:dor_gen/annotations.dart';
import 'package:example/domain/spam/model/egg.dart';

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

  void setEgg({required Egg newEgg});
}
