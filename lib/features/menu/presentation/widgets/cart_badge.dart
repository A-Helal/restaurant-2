import 'package:flutter/material.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';

class CartBadge extends StatelessWidget {
  final int itemCount;
  final VoidCallback onTap;

  const CartBadge({
    super.key,
    required this.itemCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            color: AppColors.onPrimary,
          ),
          onPressed: onTap,
        ),
        if (itemCount > 0) _buildBadge(),
      ],
    );
  }

  Widget _buildBadge() {
    return Positioned(
      right: 6,
      top: 6,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: AppColors.error,
          shape: BoxShape.circle,
        ),
        constraints: const BoxConstraints(
          minWidth: 16,
          minHeight: 16,
        ),
        child: Text(
          itemCount > 99 ? '99+' : itemCount.toString(),
          style: const TextStyle(
            color: AppColors.onError,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}