import 'package:las_customer/data/model/trash.dart';

class CartItem {
  final Trash trash;
  final int quantity;

  CartItem({
    required this.trash,
    required this.quantity,
  });

  // fromjson
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      trash: Trash.fromJson(json),
      quantity: 0,
    );
  }

  // copywith
  CartItem copyWith({
    Trash? trash,
    int? quantity,
  }) {
    return CartItem(
      trash: trash ?? this.trash,
      quantity: quantity ?? this.quantity,
    );
  }
}
