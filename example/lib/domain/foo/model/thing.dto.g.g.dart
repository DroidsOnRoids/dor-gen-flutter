// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thing.dto.g.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThingDto _$ThingDtoFromJson(Map<String, dynamic> json) => ThingDto(
      id: json['id'] as int,
      name: json['name'] as String,
      description: (json['description'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ThingDtoToJson(ThingDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
