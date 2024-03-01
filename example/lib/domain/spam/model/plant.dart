import 'package:dor_gen/annotations.dart';
import 'package:json_annotation/json_annotation.dart';

@Dto(jsonSerializable: JsonSerializable())
class Plant {
  final int id;

  const Plant({required this.id});
}
