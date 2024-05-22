import 'package:dor_gen/annotations.dart';
import 'package:equatable/equatable.dart';

@Dto(generateToDto: false)
class Thing extends Equatable {
  final int id;
  final String name;

  const Thing({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
