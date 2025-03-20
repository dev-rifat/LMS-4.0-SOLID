import 'package:hive/hive.dart';
part 'hive_object.g.dart';

@HiveType(typeId: 0)
class AddToCartItem extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String price;
  @HiveField(3)
  final String time;
  @HiveField(4)
  final String img;

  AddToCartItem(
      {required this.id,
      required this.name,
      required this.price,
      required this.time,
      required this.img});
}
