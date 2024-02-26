// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'egg.dto.g.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EggDto _$EggDtoFromJson(Map<String, dynamic> json) => EggDto(
      cats: (json['cats'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) =>
                  e == null ? null : CatDto.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      plant: PlantDto.fromJson(json['plant'] as Map<String, dynamic>),
      id: json['id'] as String,
      name: json['name'] as String?,
      description: (json['description'] as num).toDouble(),
      image: json['image'] as String,
      price: json['price'] as String,
      weight: json['weight'] as String?,
      category: json['category'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$EggDtoToJson(EggDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'weight': instance.weight,
      'category': instance.category,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt,
      'plant': instance.plant,
      'cats': instance.cats,
    };
