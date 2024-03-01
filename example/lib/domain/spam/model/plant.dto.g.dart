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

// DTO for Plant;
import 'package:json_annotation/json_annotation.dart';
import 'plant.dart';
part 'plant.dto.g.g.dart';

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
class PlantDto {
  final int id;

  const PlantDto({
    required this.id,
  });

  Map<String, dynamic> toJson() => _$PlantDtoToJson(this);

  factory PlantDto.fromJson(Map<String, dynamic> json) =>
      _$PlantDtoFromJson(json);
}

extension PlantDtoToPlant on PlantDto {
  Plant toDomain() => Plant(
        id: id,
      );
}

extension PlantToPlantDto on Plant {
  PlantDto toDto() => PlantDto(
        id: id,
      );
}
