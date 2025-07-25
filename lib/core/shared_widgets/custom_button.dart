import 'package:flutter/material.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius borderRadius;
  final IconData? icon;
  final double fontSize;
  final FontWeight fontWeight;

  CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height = 48.0,
    this.padding,
    BorderRadius? borderRadius,
    this.icon,
    this.fontSize = Constants.fontSizeLarge,
    this.fontWeight = FontWeight.w600,
  }) : borderRadius =
           borderRadius ?? BorderRadius.circular(Constants.borderRadius);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color effectiveBackgroundColor;
    Color effectiveTextColor;
    Color? effectiveBorderColor;

    if (isOutlined) {
      effectiveBackgroundColor = backgroundColor ?? Colors.transparent;
      effectiveTextColor = textColor ?? theme.primaryColor;
      effectiveBorderColor = borderColor ?? theme.primaryColor;
    } else {
      effectiveBackgroundColor = backgroundColor ?? theme.primaryColor;
      effectiveTextColor = textColor ?? Colors.white;
      effectiveBorderColor = borderColor;
    }

    if (onPressed == null && !isLoading) {
      effectiveBackgroundColor = AppColors.textDisabled;
      effectiveTextColor = AppColors.textInverse;
      effectiveBorderColor = AppColors.textDisabled;
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveTextColor,
          elevation: isOutlined ? 0 : 2,
          shadowColor: AppColors.cardShadow,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side:
                effectiveBorderColor != null
                    ? BorderSide(color: effectiveBorderColor, width: 1.5)
                    : BorderSide.none,
          ),
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: Constants.paddingLarge,
                vertical: Constants.paddingMedium,
              ),
        ),
        child:
            isLoading
                ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(effectiveTextColor),
                  ),
                )
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 20, color: effectiveTextColor),
                      const SizedBox(width: Constants.paddingSmall),
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: effectiveTextColor,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      width: width,
      icon: icon,
      backgroundColor: AppColors.primary,
      textColor: AppColors.onPrimary,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      width: width,
      icon: icon,
      isOutlined: true,
      textColor: AppColors.primary,
      borderColor: AppColors.primary,
    );
  }
}
