import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:restaurant_task/features/menu/data/models/menu_item_model.dart';
import '../../models/cart_item_model.dart';
import '../../services/cart_service.dart';
import 'cart_state.dart';

class CartCubit extends HydratedCubit<CartState> {
  final CartService _cartService = CartService();

  CartCubit() : super(CartInitial()) {
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      final items = await _cartService.loadCartItems();
      emit(CartUpdated(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addItem(MenuItem menuItem, {int quantity = 1}) async {
    try {
      final currentState = state;
      List<CartItem> currentItems = [];

      if (currentState is CartUpdated) {
        currentItems = currentState.items;
      }

      final updatedItems = await _cartService.addItem(
        currentItems,
        menuItem,
        quantity,
      );

      emit(CartUpdated(updatedItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeItem(String menuItemId) async {
    try {
      final currentState = state;
      if (currentState is CartUpdated) {
        final updatedItems = await _cartService.removeItem(
          currentState.items,
          menuItemId,
        );
        emit(CartUpdated(updatedItems));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateQuantity(String menuItemId, int newQuantity) async {
    try {
      final currentState = state;
      if (currentState is CartUpdated) {
        final updatedItems = await _cartService.updateQuantity(
          currentState.items,
          menuItemId,
          newQuantity,
        );
        emit(CartUpdated(updatedItems));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> incrementQuantity(String menuItemId) async {
    final currentState = state;
    if (currentState is CartUpdated) {
      final item = currentState.items.firstWhere(
        (item) => item.menuItem.id == menuItemId,
        orElse: () =>  CartItem(
          menuItem: MenuItem(
            id: '',
            name: '',
            price: 0,
            imageUrl: '',
          ),
          quantity: 0,
        ),
      );

      if (item.quantity > 0) {
        await updateQuantity(menuItemId, item.quantity + 1);
      }
    }
  }

  Future<void> decrementQuantity(String menuItemId) async {
    final currentState = state;
    if (currentState is CartUpdated) {
      final item = currentState.items.firstWhere(
        (item) => item.menuItem.id == menuItemId,
        orElse: () =>  CartItem(
          menuItem: MenuItem(
            id: '',
            name: '',
            price: 0,
            imageUrl: '',
          ),
          quantity: 0,
        ),
      );

      if (item.quantity > 1) {
        await updateQuantity(menuItemId, item.quantity - 1);
      } else if (item.quantity == 1) {
        await removeItem(menuItemId);
      }
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartService.clearCart();
      emit(CartUpdated([]));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  double getTotalPrice() {
    final currentState = state;
    if (currentState is CartUpdated) {
      return currentState.totalPrice;
    }
    return 0.0;
  }

  int getTotalItems() {
    final currentState = state;
    if (currentState is CartUpdated) {
      return currentState.totalItems;
    }
    return 0;
  }

  bool isCartEmpty() {
    final currentState = state;
    if (currentState is CartUpdated) {
      return currentState.items.isEmpty;
    }
    return true;
  }

  List<CartItem> getCartItems() {
    final currentState = state;
    if (currentState is CartUpdated) {
      return currentState.items;
    }
    return [];
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    try {
      final type = json['type'] as String?;
      if (type == 'CartUpdated') {
        final itemsJson = json['items'] as List?;
        if (itemsJson != null) {
          final items = itemsJson
              .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
              .toList();
          return CartUpdated(items);
        }
      }
      return CartInitial();
    } catch (_) {
      return CartInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    if (state is CartUpdated) {
      return {
        'type': 'CartUpdated',
        'items': state.items.map((item) => item.toJson()).toList(),
      };
    }
    return null;
  }
}