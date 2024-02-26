import 'package:json_annotation/json_annotation.dart';

class Dto {
  final bool generateToDto;
  final bool generateToDomain;
  final JsonSerializable? jsonSerializable;

  const Dto({
    this.generateToDto = true,
    this.generateToDomain = true,
    this.jsonSerializable,
  });
}
