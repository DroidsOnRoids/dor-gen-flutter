import 'package:dor_gen/annotations.dart';
import 'package:example/domain/spam/model/plant.dart';

@Dto()
class Egg {
  final String id;
  final String? name;
  final double description;
  final String image;
  final String price;
  String weight;
  final int category;
  final DateTime createdAt;
  final String updatedAt;
  final Plant plant;

  Egg({
    required this.plant,
    required this.id,
    this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.weight,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });
}
