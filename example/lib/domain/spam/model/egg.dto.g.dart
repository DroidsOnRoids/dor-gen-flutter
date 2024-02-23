// GENERATED CODE - DO NOT MODIFY BY HAND
//
//**************************************************************************
//*                                                                        *
//*         This code was generated using DroidsOnRoids generator          *
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
  createToJson: true,
  createFactory: true,
)
class EggDto {
  final String id;
  final String? name;
  final double description;
  final String image;
  final String price;
  String weight;
  final int category;
  final DateTime createdAt;
  final String updatedAt;
  final PlantDto plant;
  final List<Cat> cats;

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
        updatedAt: updatedAt,
        plant: plant.toDto(),
        cats: cats,
      );
}
