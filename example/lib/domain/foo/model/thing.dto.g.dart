// GENERATED CODE - DO NOT MODIFY BY HAND
//
//**************************************************************************
//*                                                                        *
//*      ⚡ This code was generated using DroidsOnRoids generator ⚡      *
//*                                                                        *
//**************************************************************************

// **************************************************************************
// DtoGenerator
// **************************************************************************

// ignore_for_file: unused_import

// DTO for Thing;
import 'package:json_annotation/json_annotation.dart';
import 'thing.dart';
part 'thing.dto.g.g.dart';

@JsonSerializable(
  anyMap: null,
  checked: null,
  constructor: null,
  createFieldMap: null,
  disallowUnrecognizedKeys: null,
  explicitToJson: null,
  ignoreUnannotated: null,
  includeIfNull: null,
  genericArgumentFactories: null,
  createPerFieldToJson: null,
  createToJson: true,
  createFactory: true,
)
class ThingDto {
  final int id;
  final String name;
  final List<String>? description;

  const ThingDto({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() => _$ThingDtoToJson(this);

  factory ThingDto.fromJson(Map<String, dynamic> json) =>
      _$ThingDtoFromJson(json);
}

extension ThingDtoToThing on ThingDto {
  Thing toDomain() => Thing(
        id: id,
        name: name,
        description: description?.map((e) => e).toList(growable: false),
      );
}

extension ThingToThingDto on Thing {
  ThingDto toDto() => ThingDto(
        id: id,
        name: name,
        description: description?.map((e) => e).toList(growable: false),
      );
}
