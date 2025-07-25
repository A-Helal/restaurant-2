import 'package:equatable/equatable.dart';
import '../../models/menu_item_model.dart';

abstract class MenuState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItem> menuItems;
  final List<MenuItem> filteredItems;
  final String searchQuery;
  
  MenuLoaded(
    this.menuItems, {
    List<MenuItem>? filteredItems,
    this.searchQuery = '',
  }) : filteredItems = filteredItems ?? menuItems;
  
  @override
  List<Object?> get props => [menuItems, filteredItems, searchQuery];
}

class MenuError extends MenuState {
  final String message;
  
  MenuError(this.message);
  
  @override
  List<Object?> get props => [message];
} 