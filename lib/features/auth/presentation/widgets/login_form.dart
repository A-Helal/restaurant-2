import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_task/core/shared_widgets/custom_button.dart';
import 'package:restaurant_task/core/shared_widgets/custom_text_field.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/core/utils/validators.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_cubit.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_state.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildEmailField(),
        const SizedBox(height: Constants.paddingLarge),
        _buildPasswordField(),
        const SizedBox(height: Constants.paddingMedium),
        _buildForgotPasswordButton(),
        const SizedBox(height: Constants.paddingXLarge),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildEmailField() {
    return EmailTextField(
      controller: emailController,
      validator: Validators.validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return PasswordTextField(
      controller: passwordController,
      validator: Validators.validatePassword,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onForgotPassword,
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: Constants.fontSizeMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return PrimaryButton(
          text: 'Sign In',
          onPressed: onLogin,
          isLoading: state is AuthLoading,
          width: double.infinity,
          icon: Icons.login,
        );
      },
    );
  }
}