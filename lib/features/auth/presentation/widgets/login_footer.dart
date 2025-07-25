import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_task/core/shared_widgets/custom_button.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';


class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(),
        const SizedBox(height: Constants.paddingLarge),
        _buildSignUpButton(context),
        const SizedBox(height: Constants.paddingLarge),
        _buildTermsText(),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.divider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.paddingMedium),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: Constants.fontSizeSmall,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.divider)),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return SecondaryButton(
      text: 'Create Account',
      onPressed: () => context.go('/signup'),
      width: double.infinity,
      icon: Icons.person_add,
    );
  }

  Widget _buildTermsText() {
    return Text(
      'By signing in, you agree to our Terms of Service and Privacy Policy.',
      style: TextStyle(
        color: AppColors.textSecondary,
        fontSize: Constants.fontSizeSmall,
      ),
      textAlign: TextAlign.center,
    );
  }
}