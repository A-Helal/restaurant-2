import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../models/menu_item_model.dart';
import '../../services/firestore_service.dart';
import 'menu_state.dart';

class MenuCubit extends HydratedCubit<MenuState> {
  final FirestoreService _firestoreService = FirestoreService();

  MenuCubit() : super(MenuInitial());

  Future<void> fetchMenuItems() async {
    emit(MenuLoading());
    try {
      final menuItems = await _firestoreService.getMenuItems();
      emit(MenuLoaded(menuItems));
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }

  void searchMenuItems(String query) {
    final currentState = state;
    if (currentState is MenuLoaded) {
      if (query.isEmpty) {
        emit(
          MenuLoaded(
            currentState.menuItems,
            filteredItems: currentState.menuItems,
            searchQuery: '',
          ),
        );
      } else {
        final searchQuery = query.toLowerCase();
        final filteredItems =
            currentState.menuItems.where((item) {
              return item.name.toLowerCase().contains(searchQuery);
            }).toList();

        emit(
          MenuLoaded(
            currentState.menuItems,
            filteredItems: filteredItems,
            searchQuery: query,
          ),
        );
      }
    }
  }

  void clearSearch() {
    final currentState = state;
    if (currentState is MenuLoaded) {
      emit(
        MenuLoaded(
          currentState.menuItems,
          filteredItems: currentState.menuItems,
          searchQuery: '',
        ),
      );
    }
  }

  @override
  MenuState? fromJson(Map<String, dynamic> json) {
    try {
      final type = json['type'] as String?;
      if (type == 'MenuLoaded') {
        final menuItemsJson = json['menuItems'] as List?;
        if (menuItemsJson != null) {
          final menuItems =
              menuItemsJson
                  .map(
                    (item) => MenuItem.fromJson(
                      item as Map<String, dynamic>,
                      item['id'] ?? '',
                    ),
                  )
                  .toList();
          return MenuLoaded(menuItems);
        }
      }
      return MenuInitial();
    } catch (_) {
      return MenuInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(MenuState state) {
    if (state is MenuLoaded) {
      return {
        'type': 'MenuLoaded',
        'menuItems': state.menuItems.map((item) => item.toJson()).toList(),
      };
    }
    return null;
  }
}
