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
part 'cat.dto.g.g.dart';

@JsonSerializable(
  createToJson: true,
  createFactory: true,
)
class CatDto {
  final int id;

  const CatDto({
    required this.id,
  });

  Map<String, dynamic> toJson() => _$CatDtoToJson(this);

  factory CatDto.fromJson(Map<String, dynamic> json) => _$CatDtoFromJson(json);
}

extension CatDtoToCat on CatDto {
  CatDto toDomain() => CatDto(
        id: id,
      );
}

extension CatToCatDto on Cat {
  CatDto toDto() => CatDto(
        id: id,
      );
}
