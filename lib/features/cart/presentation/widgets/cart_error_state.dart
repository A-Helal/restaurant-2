import 'package:flutter/material.dart';
import 'package:restaurant_task/core/shared_widgets/custom_button.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class CartErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CartErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: AppColors.error,
          ),
          const SizedBox(height: Constants.paddingLarge),
          Text(
            'Cart Error',
            style: TextStyle(
              fontSize: Constants.fontSizeXLarge,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: Constants.paddingSmall),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.paddingLarge),
            child: Text(
              message,
              style: TextStyle(
                fontSize: Constants.fontSizeMedium,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Constants.paddingLarge),
          PrimaryButton(
            text: 'Go to Menu',
            onPressed: onRetry,
            icon: Icons.restaurant_menu,
          ),
        ],
      ),
    );
  }
}