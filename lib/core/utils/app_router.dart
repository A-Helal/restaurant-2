import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_cubit.dart';
import 'package:restaurant_task/features/auth/data/cubits/auth/auth_state.dart';
import 'package:restaurant_task/features/auth/presentation/screens/login_screen.dart';
import 'package:restaurant_task/features/auth/presentation/screens/signup_screen.dart';
import 'package:restaurant_task/features/cart/presentation/screens/cart_screen.dart';
import 'package:restaurant_task/features/menu/presentation/screens/menu_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final authState = context.read<AuthCubit>().state;
      final isLoggedIn = authState is AuthAuthenticated;
      final isLoggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return '/menu';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/menu',
        name: 'menu',
        builder: (context, state) => MenuScreen(),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => CartScreen(),
      ),
      GoRoute(path: '/', redirect: (context, state) => '/menu'),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Page Not Found')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Page not found: ${state.matchedLocation}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/menu'),
                  child: const Text('Go to Menu'),
                ),
              ],
            ),
          ),
        ),
  );
}
