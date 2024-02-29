import 'package:dor_gen/annotations.dart';

@DorGenerator()
abstract class FooRepository {
  @DorConfig(
    apiMethod: ApiMethod.POST,
    path: '/api/v1/foo/doNothing',
    generateDataSourceMethod: true,
  )
  Future<void> doNothing();
}
