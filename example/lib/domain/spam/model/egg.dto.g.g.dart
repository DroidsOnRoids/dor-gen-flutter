// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'egg.dto.g.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EggDto _$EggDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'EggDto',
      json,
      ($checkedConvert) {
        final val = EggDto(
          cats: $checkedConvert(
              'cats',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as List<dynamic>)
                      .map((e) => e == null
                          ? null
                          : CatDto.fromJson(e as Map<String, dynamic>))
                      .toList())
                  .toList()),
          plant: $checkedConvert(
              'plant', (v) => PlantDto.fromJson(v as Map<String, dynamic>)),
          id: $checkedConvert('id', (v) => v as int? ?? 0),
          name: $checkedConvert('name', (v) => v as String? ?? 'default'),
          description: $checkedConvert(
              'quantity', (v) => (v as num?)?.toDouble() ?? 1.3),
          image: $checkedConvert(
            'image',
            (v) => Formatter.formatCurrency(v as double),
            readValue: readFunction,
          ),
          price: $checkedConvert('price', (v) => v as String),
          weight: $checkedConvert('weight', (v) => v as String?),
          category: $checkedConvert(
              'category',
              (v) => $enumDecode(_$CategoryEnumEnumMap, v,
                  unknownValue: CategoryEnum.other)),
          category2: $checkedConvert(
              'category2',
              (v) => $enumDecodeNullable(_$CategoryEnumEnumMap, v,
                  unknownValue: JsonKey.nullForUndefinedEnumValue)),
          createdAt:
              $checkedConvert('created-at', (v) => DateTime.parse(v as String)),
          updatedAt: $checkedConvert(
              'updated-at',
              (v) => (v as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList()),
          cat: $checkedConvert(
              'cat',
              (v) => v == null
                  ? null
                  : CatDto.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'description': 'quantity',
        'createdAt': 'created-at',
        'updatedAt': 'updated-at'
      },
    );

Map<String, dynamic> _$EggDtoToJson(EggDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.description,
      'image': superToJson(instance.image),
      'price': instance.price,
      'weight': instance.weight,
      'category': _$CategoryEnumEnumMap[instance.category]!,
      'category2': _$CategoryEnumEnumMap[instance.category2],
      'created-at': instance.createdAt.toIso8601String(),
      'updated-at': instance.updatedAt,
      'plant': instance.plant,
      'cats': instance.cats,
      'cat': instance.cat,
    };

const _$CategoryEnumEnumMap = {
  CategoryEnum.all: 'all',
  CategoryEnum.promotion: 'promotion',
  CategoryEnum.social: 'social',
  CategoryEnum.spam: 'spam',
  CategoryEnum.other: 'other',
};
