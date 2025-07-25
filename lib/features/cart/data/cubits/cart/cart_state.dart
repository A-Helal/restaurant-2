import 'package:equatable/equatable.dart';
import '../../models/cart_item_model.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> items;
  final double totalPrice;
  final int totalItems;
  
  CartUpdated(this.items)
      : totalPrice = items.fold(0.0, (sum, item) => sum + item.totalPrice),
        totalItems = items.fold(0, (sum, item) => sum + item.quantity);
  
  @override
  List<Object?> get props => [items, totalPrice, totalItems];
}

class CartError extends CartState {
  final String message;
  
  CartError(this.message);
  
  @override
  List<Object?> get props => [message];
} 