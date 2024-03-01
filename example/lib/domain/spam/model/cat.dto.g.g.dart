// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dto.g.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatDto _$CatDtoFromJson(Map<String, dynamic> json) => CatDto(
      id: json['id'] as int,
      name: json['name'] as String,
      toys: (json['toys'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CatDtoToJson(CatDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'toys': instance.toys,
    };
