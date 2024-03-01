import 'package:dor_gen/annotations.dart';

@Dto()
class Cat {
  final int id;
  final String name;
  final List<String> toys;

  const Cat({
    required this.id,
    required this.name,
    required this.toys,
  });
}
