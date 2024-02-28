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

// DTO for Cat;
import 'package:json_annotation/json_annotation.dart';
import 'cat.dart';
import 'package:dor_gen/annotations.dart';
part 'cat.dto.g.g.dart';

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
class CatDto {
  final int id;
  final String name;

  const CatDto({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$CatDtoToJson(this);

  factory CatDto.fromJson(Map<String, dynamic> json) => _$CatDtoFromJson(json);
}

extension CatDtoToCat on CatDto {
  CatDto toDomain() => CatDto(
        id: id,
        name: name,
      );
}

extension CatToCatDto on Cat {
  CatDto toDto() => CatDto(
        id: id,
        name: name,
      );
}
