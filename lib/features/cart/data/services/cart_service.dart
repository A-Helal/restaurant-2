import 'dart:convert';
import 'package:restaurant_task/features/menu/data/models/menu_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item_model.dart';

class CartService {
  static const String _cartKey = 'cart_items';

  Future<void> saveCartItems(List<CartItem> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = items.map((item) => item.toJson()).toList();
      await prefs.setString(_cartKey, jsonEncode(cartJson));
    } catch (e) {
      throw Exception('Failed to save cart items: ${e.toString()}');
    }
  }

  Future<List<CartItem>> loadCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartString = prefs.getString(_cartKey);

      if (cartString == null || cartString.isEmpty) {
        return [];
      }
      final cartJson = jsonDecode(cartString) as List;
      return cartJson
          .map((json) => CartItem.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      await clearCart();
      return [];
    }
  }

  Future<void> clearCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cartKey);
    } catch (e) {
      throw Exception('Failed to clear cart: ${e.toString()}');
    }
  }

  Future<List<CartItem>> addItem(
    List<CartItem> currentItems,
    MenuItem menuItem,
    int quantity,
  ) async {
    try {
      final updatedItems = List<CartItem>.from(currentItems);

      final existingIndex = updatedItems.indexWhere(
        (item) => item.menuItem.id == menuItem.id,
      );

      if (existingIndex != -1) {
        final existingItem = updatedItems[existingIndex];
        updatedItems[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
        );
      } else {
        // Add new item to cart
        updatedItems.add(CartItem(menuItem: menuItem, quantity: quantity));
      }

      await saveCartItems(updatedItems);
      return updatedItems;
    } catch (e) {
      throw Exception('Failed to add item to cart: ${e.toString()}');
    }
  }

  Future<List<CartItem>> removeItem(
    List<CartItem> currentItems,
    String menuItemId,
  ) async {
    try {
      final updatedItems =
          currentItems.where((item) => item.menuItem.id != menuItemId).toList();

      await saveCartItems(updatedItems);
      return updatedItems;
    } catch (e) {
      throw Exception('Failed to remove item from cart: ${e.toString()}');
    }
  }

  Future<List<CartItem>> updateQuantity(
    List<CartItem> currentItems,
    String menuItemId,
    int newQuantity,
  ) async {
    try {
      if (newQuantity <= 0) {
        return await removeItem(currentItems, menuItemId);
      }

      final updatedItems =
          currentItems.map((item) {
            if (item.menuItem.id == menuItemId) {
              return item.copyWith(quantity: newQuantity);
            }
            return item;
          }).toList();

      await saveCartItems(updatedItems);
      return updatedItems;
    } catch (e) {
      throw Exception('Failed to update item quantity: ${e.toString()}');
    }
  }
}
