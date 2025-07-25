import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_cubit.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_state.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/cart_badge.dart';

class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCartTap;
  final VoidCallback onLogoutTap;

  const MenuAppBar({
    super.key,
    required this.onCartTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      title: _buildTitle(),
      actions: [
        _buildCartButton(),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      Constants.appName,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Constants.fontSizeXLarge,
        color: AppColors.onPrimary,
      ),
    );
  }

  Widget _buildCartButton() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final itemCount = state is CartUpdated ? state.totalItems : 0;

        return CartBadge(
          itemCount: itemCount,
          onTap: onCartTap,
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: onLogoutTap,
      icon: const Icon(Icons.logout, color: AppColors.onPrimary),
      tooltip: 'Logout',
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}