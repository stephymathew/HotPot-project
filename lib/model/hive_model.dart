import 'package:hive/hive.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 1)
class Products {
  Products(
      {required this.dishImage,
      required this.dishName,
      required this.dishPrice,
      required this.dishId,
      this.id,
      this.ordered = false,
      required this.dishQuantity});
  @HiveField(0)
  String dishImage;
  @HiveField(1)
  String dishName;
  @HiveField(2)
  String dishPrice;
  @HiveField(3)
  int dishQuantity;
  @HiveField(4)
  int? id;
  @HiveField(5)
  String dishId;
  @HiveField(6)
  bool ordered;
}
