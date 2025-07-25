import 'package:flutter/material.dart';
import 'package:restaurant_task/core/shared_widgets/custom_button.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class CartEmptyState extends StatelessWidget {
  final VoidCallback onBrowseMenu;

  const CartEmptyState({
    super.key,
    required this.onBrowseMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: AppColors.iconSecondary,
          ),
          const SizedBox(height: Constants.paddingLarge),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: Constants.fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: Constants.paddingSmall),
          Text(
            'Add some delicious items to get started!',
            style: TextStyle(
              fontSize: Constants.fontSizeMedium,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Constants.paddingXLarge),
          PrimaryButton(
            text: 'Browse Menu',
            onPressed: onBrowseMenu,
            icon: Icons.restaurant_menu,
            width: 200,
          ),
        ],
      ),
    );
  }
}