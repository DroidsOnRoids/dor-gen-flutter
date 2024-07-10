import 'package:dor_gen/annotations.dart';
import 'package:equatable/equatable.dart';

@Dto(generateToDto: true)
class Thing extends Equatable {
  final int id;
  final String name;
  final List<String>? description;

  const Thing({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
      ];
}
