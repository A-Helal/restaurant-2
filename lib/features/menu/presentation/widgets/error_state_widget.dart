import 'package:flutter/material.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorStateWidget({
    super.key,
    required this.message,
    this.onRetry,
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
          _buildMessage(),
          const SizedBox(height: Constants.paddingLarge),
          if (onRetry != null) _buildRetryButton(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      Icons.error_outline,
      size: 80,
      color: AppColors.error,
    );
  }

  Widget _buildTitle() {
    return Text(
      'Oops! Something went wrong',
      style: TextStyle(
        fontSize: Constants.fontSizeXLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.paddingLarge,
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: Constants.fontSizeMedium,
          color: AppColors.textSecondary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRetryButton() {
    return ElevatedButton.icon(
      onPressed: onRetry,
      icon: const Icon(Icons.refresh),
      label: const Text('Try Again'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
      ),
    );
  }
}