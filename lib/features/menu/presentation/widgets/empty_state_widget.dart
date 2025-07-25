import 'package:flutter/material.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class EmptyStateWidget extends StatelessWidget {
  final bool hasSearchQuery;

  const EmptyStateWidget({
    super.key,
    this.hasSearchQuery = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const SizedBox(height: Constants.paddingLarge),
          _buildTitle(),
          const SizedBox(height: Constants.paddingSmall),
          _buildSubtitle(),
          const SizedBox(height: Constants.paddingLarge),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      Icons.search_off,
      size: 80,
      color: AppColors.iconSecondary,
    );
  }

  Widget _buildTitle() {
    return Text(
      'No items found',
      style: TextStyle(
        fontSize: Constants.fontSizeXLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      hasSearchQuery
          ? 'Try searching with different keywords'
          : 'No items available in this category',
      style: TextStyle(
        fontSize: Constants.fontSizeMedium,
        color: AppColors.textSecondary,
      ),
      textAlign: TextAlign.center,
    );
  }
}