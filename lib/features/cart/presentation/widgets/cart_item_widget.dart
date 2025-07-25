import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/cart/data/models/cart_item_model.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/loading_widget.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final void Function(int quantity)? onQuantityChanged;
  final VoidCallback? onRemove;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    this.onQuantityChanged,
    this.onRemove,
  });

  bool _isBase64(String url) {
    return url.startsWith('data:image') ||
        (url.length > 100 && !url.startsWith('http'));
  }

  Widget _buildBase64Image(String base64String) {
    try {
      final cleaned = base64String.split(',').last;
      Uint8List bytes = base64Decode(cleaned);
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        errorBuilder:
            (context, error, stackTrace) => Container(
              color: AppColors.shimmerBase,
              child: Icon(
                Icons.restaurant,
                size: 30,
                color: AppColors.iconSecondary,
              ),
            ),
      );
    } catch (e) {
      return Container(
        color: AppColors.shimmerBase,
        child: Icon(Icons.restaurant, size: 30, color: AppColors.iconSecondary),
      );
    }
  }

  Widget _buildImage(String imageUrl) {
    if (_isBase64(imageUrl)) {
      return _buildBase64Image(imageUrl);
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl.isEmpty ? Constants.placeholderImageUrl : imageUrl,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Container(
              color: AppColors.shimmerBase,
              child: const Center(child: SmallLoadingWidget()),
            ),
        errorWidget:
            (context, url, error) => Container(
              color: AppColors.shimmerBase,
              child: Icon(
                Icons.restaurant,
                size: 30,
                color: AppColors.iconSecondary,
              ),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: Constants.paddingMedium),
      elevation: 2,
      shadowColor: AppColors.cardShadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Constants.paddingMedium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Constants.smallBorderRadius),
              child: SizedBox(
                width: 80,
                height: 80,
                child: _buildImage(cartItem.menuItem.imageUrl),
              ),
            ),
            const SizedBox(width: Constants.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.menuItem.name,
                    style: const TextStyle(
                      fontSize: Constants.fontSizeLarge,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Constants.paddingSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            NumberFormat.currency(
                              symbol: Constants.currencySymbol,
                              decimalDigits: 2,
                            ).format(cartItem.menuItem.price),
                            style: const TextStyle(
                              fontSize: Constants.fontSizeSmall,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              symbol: Constants.currencySymbol,
                              decimalDigits: 2,
                            ).format(cartItem.totalPrice),
                            style: const TextStyle(
                              fontSize: Constants.fontSizeLarge,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      _buildQuantityControls(),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onRemove,
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.error,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControls() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(Constants.smallBorderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:
                  cartItem.quantity > 1
                      ? () => onQuantityChanged?.call(cartItem.quantity - 1)
                      : null,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Constants.smallBorderRadius),
                bottomLeft: Radius.circular(Constants.smallBorderRadius),
              ),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color:
                      cartItem.quantity > 1
                          ? Colors.transparent
                          : AppColors.surfaceContainer,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Constants.smallBorderRadius),
                    bottomLeft: Radius.circular(Constants.smallBorderRadius),
                  ),
                ),
                child: Icon(
                  Icons.remove,
                  size: 16,
                  color:
                      cartItem.quantity > 1
                          ? AppColors.textPrimary
                          : AppColors.textDisabled,
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 32,
            decoration: const BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(color: AppColors.outline),
              ),
            ),
            child: Center(
              child: Text(
                cartItem.quantity.toString(),
                style: const TextStyle(
                  fontSize: Constants.fontSizeMedium,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:
                  cartItem.quantity < 99
                      ? () => onQuantityChanged?.call(cartItem.quantity + 1)
                      : null,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(Constants.smallBorderRadius),
                bottomRight: Radius.circular(Constants.smallBorderRadius),
              ),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color:
                      cartItem.quantity < 99
                          ? Colors.transparent
                          : AppColors.surfaceContainer,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(Constants.smallBorderRadius),
                    bottomRight: Radius.circular(Constants.smallBorderRadius),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: 16,
                  color:
                      cartItem.quantity < 99
                          ? AppColors.textPrimary
                          : AppColors.textDisabled,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
