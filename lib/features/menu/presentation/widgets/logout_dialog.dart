import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_cubit.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_state.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutDialog({
    super.key,
    required this.onConfirm,
  });

  static void show({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => LogoutDialog(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      title: _buildTitle(),
      content: _buildContent(),
      actions: [
        _buildCancelButton(context),
        _buildLogoutButton(context),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text('Logout');
  }

  Widget _buildContent() {
    return const Text('Are you sure you want to logout?');
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(context).pop(); // Close dialog
          context.go('/login');
        }
      },
      child: ElevatedButton(
        onPressed: onConfirm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          foregroundColor: AppColors.onError,
        ),
        child: const Text('Logout'),
      ),
    );
  }
}