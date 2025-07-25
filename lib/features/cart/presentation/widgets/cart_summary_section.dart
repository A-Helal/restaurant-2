import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_task/core/shared_widgets/custom_button.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_state.dart';

class CartSummarySection extends StatelessWidget {
  final CartUpdated state;
  final VoidCallback onCheckout;

  const CartSummarySection({
    super.key,
    required this.state,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Constants.paddingLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _OrderSummaryCard(state: state),
              if (state.totalPrice < 25.0) ...[
                const SizedBox(height: Constants.paddingMedium),
                _FreeDeliveryBanner(remainingAmount: 25.0 - state.totalPrice),
              ],
              const SizedBox(height: Constants.paddingLarge),
              PrimaryButton(
                text: 'Proceed to Checkout',
                onPressed: onCheckout,
                width: double.infinity,
                icon: Icons.payment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  final CartUpdated state;

  const _OrderSummaryCard({required this.state});

  double get deliveryFee => state.totalPrice >= 25.0 ? 0.0 : 2.99;
  double get totalAmount => state.totalPrice + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: 'Items (${state.totalItems})',
            value: _formatCurrency(state.totalPrice),
          ),
          const SizedBox(height: Constants.paddingSmall),
          _SummaryRow(
            label: 'Delivery Fee',
            value: deliveryFee == 0 ? 'FREE' : _formatCurrency(deliveryFee),
            valueColor: deliveryFee == 0 ? AppColors.success : AppColors.textPrimary,
            isHighlighted: deliveryFee == 0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Constants.paddingSmall),
            child: Divider(color: AppColors.divider),
          ),
          _SummaryRow(
            label: 'Total',
            value: _formatCurrency(totalAmount),
            labelStyle: const TextStyle(
              fontSize: Constants.fontSizeLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            valueStyle: const TextStyle(
              fontSize: Constants.fontSizeLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      symbol: Constants.currencySymbol,
      decimalDigits: 2,
    ).format(amount);
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isHighlighted;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isHighlighted = false,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: labelStyle ??
              const TextStyle(
                fontSize: Constants.fontSizeMedium,
                color: AppColors.textSecondary,
              ),
        ),
        Text(
          value,
          style: valueStyle ??
              TextStyle(
                fontSize: Constants.fontSizeMedium,
                color: valueColor ?? AppColors.textPrimary,
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
              ),
        ),
      ],
    );
  }
}

class _FreeDeliveryBanner extends StatelessWidget {
  final double remainingAmount;

  const _FreeDeliveryBanner({required this.remainingAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.warningContainer,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_shipping,
            color: AppColors.onWarningContainer,
            size: 20,
          ),
          const SizedBox(width: Constants.paddingSmall),
          Expanded(
            child: Text(
              'Add ${NumberFormat.currency(
                symbol: Constants.currencySymbol,
                decimalDigits: 2,
              ).format(remainingAmount)} more for FREE delivery!',
              style: const TextStyle(
                fontSize: Constants.fontSizeSmall,
                color: AppColors.onWarningContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}