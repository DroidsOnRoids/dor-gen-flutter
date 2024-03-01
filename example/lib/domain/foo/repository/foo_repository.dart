import 'package:dor_gen/annotations.dart';
import 'package:example/domain/foo/model/thing.dart';

@DorGenerator()
abstract class FooRepository {
  @DorConfig(
    apiMethod: ApiMethod.POST,
    path: '/api/v1/foo/doNothing',
  )
  Future<Thing> doSomething({
    required String id,
    required String name,
  });
}
