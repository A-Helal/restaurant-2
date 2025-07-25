import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_cubit.dart';
import 'package:restaurant_task/features/menu/data/cubits/menu/menu_cubit.dart';
import 'package:restaurant_task/features/menu/data/cubits/menu/menu_state.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/empty_state_widget.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/error_state_widget.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/loading_widget.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/logout_dialog.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/menu_app_bar.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/menu_grid.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/search_items.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MenuAppBar(
        onCartTap: () => context.go('/cart'),
        onLogoutTap: _showLogoutDialog,
      ),
      body: Column(children: [SearchItems(), _buildMenuContent()]),
    );
  }

  Widget _buildMenuContent() {
    return Expanded(
      child: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          return switch (state) {
            MenuLoading() => const LoadingWidget(
              message: 'Loading delicious menu...',
            ),
            MenuLoaded() => _buildLoadedContent(state),
            MenuError() => ErrorStateWidget(message: state.message),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildLoadedContent(MenuLoaded state) {
    final menuItems = state.filteredItems;

    if (menuItems.isEmpty) {
      return EmptyStateWidget(
        hasSearchQuery: _searchController.text.isNotEmpty,
      );
    }

    return MenuGrid(menuItems: menuItems);
  }

  void _initializeScreen() {
    context.read<MenuCubit>().fetchMenuItems();
  }

  void _showLogoutDialog() {
    LogoutDialog.show(context: context, onConfirm: () => _handleLogout());
  }

  void _handleLogout() {
    context.read<AuthCubit>().signOut();
  }
}
