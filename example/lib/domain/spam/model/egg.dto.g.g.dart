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
                      .map((e) => CatDto.fromJson(e as Map<String, dynamic>))
                      .toList())
                  .toList()),
          plant: $checkedConvert(
              'plant', (v) => PlantDto.fromJson(v as Map<String, dynamic>)),
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String?),
          description:
              $checkedConvert('description', (v) => (v as num).toDouble()),
          image: $checkedConvert('image', (v) => v as String),
          price: $checkedConvert('price', (v) => v as String),
          weight: $checkedConvert('weight', (v) => v as String?),
          category: $checkedConvert('category', (v) => v as int),
          createdAt:
              $checkedConvert('created-at', (v) => DateTime.parse(v as String)),
          updatedAt: $checkedConvert('updated-at',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created-at', 'updatedAt': 'updated-at'},
    );

Map<String, dynamic> _$EggDtoToJson(EggDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'weight': instance.weight,
      'category': instance.category,
      'created-at': instance.createdAt.toIso8601String(),
      'updated-at': instance.updatedAt,
      'plant': instance.plant,
      'cats': instance.cats,
    };
