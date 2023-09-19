import 'package:hive/hive.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late double price;

  @HiveField(2)
  late String image;

  CartItem({
    required this.title,
    required this.price,
    required this.image,
  });
}
