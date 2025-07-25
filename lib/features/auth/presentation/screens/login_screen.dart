import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_cubit.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_state.dart';
import 'package:restaurant_task/features/auth/presentation/widgets/forgot_password_dialog.dart';
import 'package:restaurant_task/features/auth/presentation/widgets/login_footer.dart';
import 'package:restaurant_task/features/auth/presentation/widgets/login_form.dart';
import 'package:restaurant_task/features/auth/presentation/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocListener<AuthCubit, AuthState>(
        listener: _handleAuthStateChange,
        child: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Constants.paddingLarge),
            child: LoginContent(),
          ),
        ),
      ),
    );
  }

  void _handleAuthStateChange(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      context.go('/menu');
    } else if (state is AuthError) {
      _showErrorSnackBar(context, state.message);
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(Constants.paddingMedium),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.smallBorderRadius),
        ),
      ),
    );
  }
}

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: size.height * 0.08),
          const LoginHeader(),
          SizedBox(height: size.height * 0.06),
          LoginForm(
            emailController: _emailController,
            passwordController: _passwordController,
            onLogin: _handleLogin,
            onForgotPassword: _showForgotPasswordDialog,
          ),
          const SizedBox(height: Constants.paddingLarge),
          const LoginFooter(),
        ],
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => const ForgotPasswordDialog(),
    );
  }
}
