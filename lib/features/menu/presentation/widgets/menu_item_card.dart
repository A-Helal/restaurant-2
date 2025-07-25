import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/cart/data/cubits/cart/cart_cubit.dart';
import 'package:restaurant_task/features/menu/data/models/menu_item_model.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/add_to_cart_button_size.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/menu_item_detail_sheet.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/menu_item_image.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/price_display.dart';


class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback? onTap;

  const MenuItemCard({super.key, required this.menuItem, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: AppColors.cardShadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: InkWell(
        onTap: onTap ?? () => _navigateToDetails(context),
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImageSection(), _buildContentSection(context)],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Expanded(
      flex: 3,
      child: MenuItemImage(
        imageUrl: menuItem.imageUrl,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Constants.borderRadius),
          topRight: Radius.circular(Constants.borderRadius),
        ),
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(Constants.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: _buildItemName()),
            const SizedBox(height: Constants.paddingSmall),
            Flexible(child: _buildPriceAndAddButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemName() {
    return Text(
      menuItem.name,
      style: const TextStyle(
        fontSize: Constants.fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceAndAddButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PriceDisplay(
          price: menuItem.price,
          fontSize: Constants.fontSizeLarge,
          fontWeight: FontWeight.bold,
        ),
        AddToCartButton(
          onPressed: () => _addToCart(context),
          size: AddToCartButtonSize.small,
        ),
      ],
    );
  }

  void _addToCart(BuildContext context) {
    context.read<CartCubit>().addItem(menuItem);
    _showSuccessSnackbar(context, '${menuItem.name} added to cart!');
  }

  void _navigateToDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Constants.largeBorderRadius),
          topRight: Radius.circular(Constants.largeBorderRadius),
        ),
      ),
      builder: (context) => MenuItemDetailSheet(menuItem: menuItem),
    );
  }

  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.onSuccess,
              size: 20,
            ),
            const SizedBox(width: Constants.paddingSmall),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: AppColors.onSuccess),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(Constants.paddingMedium),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.smallBorderRadius),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
