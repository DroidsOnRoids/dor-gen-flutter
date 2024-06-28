import 'package:dor_gen/annotations.dart';
import 'package:example/domain/spam/model/cat.dart';
import 'package:example/domain/spam/model/category_enum.dart';
import 'package:example/domain/spam/model/plant.dart';
import 'package:example/utils/formatter.dart';
import 'package:json_annotation/json_annotation.dart';

@Dto(
  jsonSerializable: JsonSerializable(
    checked: true,
    fieldRename: FieldRename.kebab,
  ),
)
class Egg {
  @DtoConfig(
    jsonKey: JsonKey(
      defaultValue: 0,
    ),
  )
  final int id;

  @DtoConfig(jsonKey: JsonKey(defaultValue: 'default', required: false))
  final String? name;

  @DtoConfig(
    jsonKey: JsonKey(
      defaultValue: 01.3,
      name: 'quantity',
    ),
  )
  final double description;
  @DtoConfig(
    jsonKey: JsonKey(
      toJson: superToJson,
      fromJson: Formatter.formatCurrency,
      readValue: readFunction,
    ),
  )
  final String image;
  final String price;
  String? weight;
  @DtoConfig(
    jsonKey: JsonKey(
      unknownEnumValue: CategoryEnum.other,
    ),
  )
  final CategoryEnum category;
  @DtoConfig(
    jsonKey: JsonKey(
      unknownEnumValue: JsonKey.nullForUndefinedEnumValue,
    ),
  )
  final CategoryEnum? category2;
  final DateTime createdAt;
  final List<double> updatedAt;
  final Plant plant;
  final List<List<Cat?>> cats;
  final Cat? cat;

  Egg({
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
}

String superToJson(String updatedAt) {
  return '${updatedAt}default';
}

String readFunction(Map<dynamic, dynamic> p0, String p1) => p1;
