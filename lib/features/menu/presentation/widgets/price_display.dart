import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class PriceDisplay extends StatelessWidget {
  final double price;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const PriceDisplay({
    super.key,
    required this.price,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      NumberFormat.currency(
        symbol: Constants.currencySymbol,
        decimalDigits: 2,
      ).format(price),
      style: TextStyle(
        fontSize: fontSize ?? Constants.fontSizeMedium,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.primary,
      ),
    );
  }
}