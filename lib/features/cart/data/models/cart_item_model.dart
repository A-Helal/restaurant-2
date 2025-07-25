import 'package:equatable/equatable.dart';
import 'package:restaurant_task/features/menu/data/models/menu_item_model.dart';

class CartItem extends Equatable {
  final MenuItem menuItem;
  final int quantity;

  const CartItem({
    required this.menuItem,
    required this.quantity,
  });

  @override
  List<Object?> get props => [menuItem, quantity];

  double get totalPrice => menuItem.price * quantity;

  Map<String, dynamic> toJson() => {
    'menuItem': menuItem.toJson(),
    'quantity': quantity,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    menuItem: MenuItem.fromJson(
      json['menuItem'] ?? {},
      json['menuItem']?['id'] ?? '',
    ),
    quantity: json['quantity'] ?? 1,
  );

  CartItem copyWith({
    MenuItem? menuItem,
    int? quantity,
  }) {
    return CartItem(
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
    );
  }
}