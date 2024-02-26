import 'package:dor_gen/annotations.dart';
import 'package:json_annotation/json_annotation.dart';

@Dto(jsonSerializable: JsonSerializable())
class Cat {
  final int id;
  final String name;

  const Cat({
    required this.id,
    required this.name,
  });
}
