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

// DTO for Egg;
import 'package:json_annotation/json_annotation.dart';
import 'egg.dart';
import 'package:example/domain/spam/model/plant.dart';
import 'package:example/domain/spam/model/plant.dto.g.dart';
import 'package:example/domain/spam/model/cat.dart';
import 'package:example/domain/spam/model/cat.dto.g.dart';
part 'egg.dto.g.g.dart';

@JsonSerializable(
  anyMap: null,
  checked: true,
  constructor: null,
  createFieldMap: null,
  disallowUnrecognizedKeys: null,
  explicitToJson: null,
  fieldRename: FieldRename.kebab,
  ignoreUnannotated: null,
  includeIfNull: null,
  genericArgumentFactories: null,
  createPerFieldToJson: null,
  createToJson: true,
  createFactory: true,
)
class EggDto {
  final String id;
  final String? name;
  final double description;
  final String image;
  final String price;
  String? weight;
  final int category;
  final DateTime createdAt;
  final List<String> updatedAt;
  final PlantDto plant;
  final List<List<CatDto>> cats;

  EggDto({
    required this.cats,
    required this.plant,
    required this.id,
    this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.weight,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => _$EggDtoToJson(this);

  factory EggDto.fromJson(Map<String, dynamic> json) => _$EggDtoFromJson(json);
}

extension EggDtoToEgg on EggDto {
  EggDto toDomain() => EggDto(
        id: id,
        name: name,
        description: description,
        image: image,
        price: price,
        weight: weight,
        category: category,
        createdAt: createdAt,
        updatedAt: updatedAt.map((e) => e).toList(growable: false),
        plant: plant.toDomain(),
        cats: cats
            .map((e) => e.map((e) => e.toDomain()).toList(growable: false))
            .toList(growable: false),
      );
}

extension EggToEggDto on Egg {
  EggDto toDto() => EggDto(
        id: id,
        name: name,
        description: description,
        image: image,
        price: price,
        weight: weight,
        category: category,
        createdAt: createdAt,
        updatedAt: updatedAt.map((e) => e).toList(growable: false),
        plant: plant.toDto(),
        cats: cats
            .map((e) => e.map((e) => e.toDto()).toList(growable: false))
            .toList(growable: false),
      );
}
