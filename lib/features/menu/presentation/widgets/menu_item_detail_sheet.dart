import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_task/core/shared_widgets/bottom_sheet_handle.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_cubit.dart';
import 'package:restaurant_task/features/menu/data/models/menu_item_model.dart';
import 'menu_item_image.dart';
import 'price_display.dart';
import 'quantity_selector.dart';

class MenuItemDetailSheet extends StatefulWidget {
  final MenuItem menuItem;

  const MenuItemDetailSheet({super.key, required this.menuItem});

  @override
  State<MenuItemDetailSheet> createState() => _MenuItemDetailSheetState();
}

class _MenuItemDetailSheetState extends State<MenuItemDetailSheet> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Constants.largeBorderRadius),
          topRight: Radius.circular(Constants.largeBorderRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildContent(),
          _buildAddToCartButton(),
          _buildSafeArea(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(
        top: Constants.paddingLarge,
        bottom: Constants.paddingMedium,
      ),
      child: BottomSheetHandle(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(height: Constants.paddingLarge),
          _buildItemName(),
          const SizedBox(height: Constants.paddingLarge),
          _buildQuantityAndPrice(),
          const SizedBox(height: Constants.paddingXLarge),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return MenuItemImage(
      imageUrl: widget.menuItem.imageUrl,
      height: 200,
      borderRadius: BorderRadius.circular(Constants.borderRadius),
    );
  }

  Widget _buildItemName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.menuItem.name,
          style: const TextStyle(
            fontSize: Constants.fontSizeTitle,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuantitySelector(
          quantity: _quantity,
          onIncrement: _incrementQuantity,
          onDecrement: _decrementQuantity,
        ),
        PriceDisplay(
          price: _calculateTotalPrice(),
          fontSize: Constants.fontSizeTitle,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    final totalPrice = _calculateTotalPrice();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.paddingLarge,
        vertical: Constants.paddingLarge,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _addToCart,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              vertical: Constants.paddingLarge,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
            ),
          ),
          child: Text(
            'Add to Cart - ${NumberFormat.currency(symbol: Constants.currencySymbol, decimalDigits: 2).format(totalPrice)}',
            style: const TextStyle(
              fontSize: Constants.fontSizeLarge,
              fontWeight: FontWeight.w600,
              color: AppColors.onPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(height: MediaQuery.of(context).padding.bottom);
  }

  double _calculateTotalPrice() {
    return widget.menuItem.price * _quantity;
  }

  void _incrementQuantity() {
    if (_quantity < 99) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    context.read<CartCubit>().addItem(widget.menuItem, quantity: _quantity);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_quantity x ${widget.menuItem.name} added to cart!',
          style: const TextStyle(color: AppColors.onSuccess),
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.smallBorderRadius),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
