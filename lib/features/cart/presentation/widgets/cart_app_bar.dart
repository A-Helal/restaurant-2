import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_cubit.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_state.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onClearPressed;

  const CartAppBar({
    super.key,
    required this.onBackPressed,
    required this.onClearPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      title: const Text(
        'Shopping Cart',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Constants.fontSizeXLarge,
          color: AppColors.onPrimary,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.onPrimary),
        onPressed: onBackPressed,
      ),
      actions: [
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartUpdated && state.items.isNotEmpty) {
              return TextButton(
                onPressed: onClearPressed,
                child: const Text(
                  'Clear All',
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}