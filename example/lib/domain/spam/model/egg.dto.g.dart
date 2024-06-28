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
import 'package:example/utils/formatter.dart';
import 'package:example/domain/spam/model/category_enum.dart';
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
  @JsonKey(
    defaultValue: 0,
    disallowNullValue: null,
    includeFromJson: null,
    includeIfNull: null,
    includeToJson: null,
    required: null,
  )
  final int id;
  @JsonKey(
    defaultValue: 'default',
    disallowNullValue: null,
    includeFromJson: null,
    includeIfNull: null,
    includeToJson: null,
    required: false,
  )
  final String? name;
  @JsonKey(
    defaultValue: 1.3,
    disallowNullValue: null,
    includeFromJson: null,
    includeIfNull: null,
    includeToJson: null,
    name: 'quantity',
    required: null,
  )
  final double description;
  @JsonKey(
    defaultValue: null,
    disallowNullValue: null,
    fromJson: Formatter.formatCurrency,
    includeFromJson: null,
    includeIfNull: null,
    includeToJson: null,
    readValue: readFunction,
    required: null,
    toJson: superToJson,
  )
  final String image;
  final String price;
  String? weight;
  @JsonKey(
    defaultValue: null,
    disallowNullValue: null,
    includeFromJson: null,
    includeIfNull: null,
    includeToJson: null,
    required: null,
    unknownEnumValue: CategoryEnum.other,
  )
  final CategoryEnum category;
  @JsonKey(
    defaultValue: null,
    disallowNullValue: null,
    includeFromJson: null,
    includeIfNull: null,
    includeToJson: null,
    required: null,
    unknownEnumValue: JsonKey.nullForUndefinedEnumValue,
  )
  final CategoryEnum? category2;
  final DateTime createdAt;
  final List<double> updatedAt;
  final PlantDto plant;
  final List<List<CatDto?>> cats;
  final CatDto? cat;

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
    required this.category2,
    required this.createdAt,
    required this.updatedAt,
    required this.cat,
  });

  Map<String, dynamic> toJson() => _$EggDtoToJson(this);

  factory EggDto.fromJson(Map<String, dynamic> json) => _$EggDtoFromJson(json);
}

extension EggDtoToEgg on EggDto {
  Egg toDomain() => Egg(
        id: id,
        name: name,
        description: description,
        image: image,
        price: price,
        weight: weight,
        category: category,
        category2: category2,
        createdAt: createdAt,
        updatedAt: updatedAt.map((e) => e).toList(growable: false),
        plant: plant.toDomain(),
        cats: cats
            .map((e) => e.map((e) => e?.toDomain()).toList(growable: false))
            .toList(growable: false),
        cat: cat?.toDomain(),
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
        category2: category2,
        createdAt: createdAt,
        updatedAt: updatedAt.map((e) => e).toList(growable: false),
        plant: plant.toDto(),
        cats: cats
            .map((e) => e.map((e) => e?.toDto()).toList(growable: false))
            .toList(growable: false),
        cat: cat?.toDto(),
      );
}
