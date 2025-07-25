import 'package:flutter/material.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          _buildAppLogo(),
          const SizedBox(height: Constants.paddingLarge),
          _buildAppTitle(context),
          const SizedBox(height: Constants.paddingSmall),
          _buildSubtitle(context),
        ],
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      padding: const EdgeInsets.all(Constants.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(Constants.largeBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(Icons.restaurant, size: 50, color: AppColors.onPrimary),
    );
  }

  Widget _buildAppTitle(BuildContext context) {
    return Text(
      Constants.appName,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      'Welcome back! Please sign in to continue.',
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
      textAlign: TextAlign.center,
    );
  }
}
