import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_task/core/shared_widgets/custom_text_field.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/core/utils/validators.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_cubit.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_state.dart';
import 'package:restaurant_task/features/menu/presentation/widgets/loading_widget.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      title: const Text('Reset Password'),
      content: _buildDialogContent(),
      actions: _buildDialogActions(),
    );
  }

  Widget _buildDialogContent() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInstructionText(),
          const SizedBox(height: Constants.paddingLarge),
          _buildEmailField(),
        ],
      ),
    );
  }

  Widget _buildInstructionText() {
    return Text(
      'Enter your email address and we\'ll send you a link to reset your password.',
      style: TextStyle(
        color: AppColors.textSecondary,
        fontSize: Constants.fontSizeMedium,
      ),
    );
  }

  Widget _buildEmailField() {
    return EmailTextField(
      controller: _emailController,
      validator: Validators.validateEmail,
    );
  }

  List<Widget> _buildDialogActions() {
    return [_buildCancelButton(), _buildResetButton()];
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    );
  }

  Widget _buildResetButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is AuthLoading ? null : _handleResetPassword,
          child:
              state is AuthLoading
                  ? const SmallLoadingWidget()
                  : const Text('Send Reset Email'),
        );
      },
    );
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().resetPassword(_emailController.text.trim());
      Navigator.of(context).pop();
      _showSuccessSnackBar();
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password reset email sent. Please check your inbox.'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}
