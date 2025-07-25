import 'package:flutter/material.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

enum AddToCartButtonSize { small, medium, large }

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final AddToCartButtonSize size;
  final String? text;

  const AddToCartButton({
    super.key,
    required this.onPressed,
    this.size = AddToCartButtonSize.medium,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final buttonConfig = _getButtonConfig(size);

    return Container(
      height: buttonConfig.height,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(Constants.smallBorderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(Constants.smallBorderRadius),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: buttonConfig.horizontalPadding,
              vertical: buttonConfig.verticalPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_shopping_cart,
                  size: buttonConfig.iconSize,
                  color: AppColors.onPrimary,
                ),
                if (text != null || size != AddToCartButtonSize.small) ...[
                  SizedBox(width: buttonConfig.spacing),
                  Text(
                    text ?? 'Add',
                    style: TextStyle(
                      fontSize: buttonConfig.fontSize,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  _ButtonConfig _getButtonConfig(AddToCartButtonSize size) {
    switch (size) {
      case AddToCartButtonSize.small:
        return _ButtonConfig(
          height: 32,
          horizontalPadding: Constants.paddingMedium,
          verticalPadding: 6,
          iconSize: 16,
          fontSize: Constants.fontSizeSmall,
          spacing: 4,
        );
      case AddToCartButtonSize.medium:
        return _ButtonConfig(
          height: 40,
          horizontalPadding: Constants.paddingLarge,
          verticalPadding: Constants.paddingSmall,
          iconSize: 20,
          fontSize: Constants.fontSizeMedium,
          spacing: Constants.paddingSmall,
        );
      case AddToCartButtonSize.large:
        return _ButtonConfig(
          height: 48,
          horizontalPadding: Constants.paddingXLarge,
          verticalPadding: Constants.paddingMedium,
          iconSize: 24,
          fontSize: Constants.fontSizeLarge,
          spacing: Constants.paddingSmall,
        );
    }
  }
}

class _ButtonConfig {
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double iconSize;
  final double fontSize;
  final double spacing;

  const _ButtonConfig({
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.iconSize,
    required this.fontSize,
    required this.spacing,
  });
}