import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_cubit.dart';

class CartDialogs {
  CartDialogs._(); // Private constructor to prevent instantiation

  static void showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
        title: const Text('Clear Cart'),
        content: const Text(
          'Are you sure you want to remove all items from your cart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _handleClearCart(context, dialogContext),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.onError,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  static void showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 28,
            ),
            const SizedBox(width: Constants.paddingSmall),
            const Text('Order Placed!'),
          ],
        ),
        content: const _CheckoutDialogContent(),
        actions: [
          ElevatedButton(
            onPressed: () => _handleCheckoutComplete(context, dialogContext),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  static void _handleClearCart(BuildContext context, BuildContext dialogContext) {
    context.read<CartCubit>().clearCart();
    Navigator.of(dialogContext).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cart cleared'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  static void _handleCheckoutComplete(BuildContext context, BuildContext dialogContext) {
    context.read<CartCubit>().clearCart();
    Navigator.of(dialogContext).pop();
    context.go('/menu');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order placed successfully! (Demo)'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}

class _CheckoutDialogContent extends StatelessWidget {
  const _CheckoutDialogContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thank you for your order! This is a demo app, so no actual payment was processed.',
        ),
        const SizedBox(height: Constants.paddingMedium),
        const Text(
          'In a real app, this would integrate with:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: Constants.paddingSmall),
        ..._buildFeatureList(),
      ],
    );
  }

  List<Widget> _buildFeatureList() {
    final features = [
      'Payment processing (Stripe, PayPal, etc.)',
      'Order management system',
      'Real-time order tracking',
      'Push notifications',
    ];

    return features
        .map((feature) => Text('• $feature'))
        .toList();
  }
}