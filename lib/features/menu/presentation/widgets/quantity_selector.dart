import 'package:flutter/material.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int minQuantity;
  final int maxQuantity;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.minQuantity = 1,
    this.maxQuantity = 99,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildQuantityButton(
              icon: Icons.remove,
              onPressed: quantity > minQuantity ? onDecrement : null,
            ),
            VerticalDivider(color: AppColors.primary, width: 10, thickness: 1),
            _buildQuantityDisplay(),

            VerticalDivider(color: AppColors.primary, width: 10, thickness: 1),
            _buildQuantityButton(
              icon: Icons.add,
              onPressed: quantity < maxQuantity ? onIncrement : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      color: AppColors.textPrimary,
    );
  }

  Widget _buildQuantityDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Constants.paddingMedium),
      child: Text(
        quantity.toString(),
        style: const TextStyle(
          fontSize: Constants.fontSizeLarge,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
