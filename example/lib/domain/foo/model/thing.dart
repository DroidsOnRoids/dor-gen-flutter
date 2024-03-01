import 'package:dor_gen/annotations.dart';

@Dto()
class Thing {
  final int id;
  final String name;

  const Thing({
    required this.id,
    required this.name,
  });
}
