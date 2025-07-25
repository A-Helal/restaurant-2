import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthInitial()) {
    _authService.authStateChanges.listen((user) {
      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          email: user.email ?? '',
          displayName: user.displayName ?? user.email?.split('@')[0] ?? 'User',
        );
        emit(AuthAuthenticated(userModel));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> checkAuthStatus() async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthError('Please fill in all fields'));
      return;
    }

    emit(AuthLoading());
    try {
      final user = await _authService.signIn(email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(String email, String password, String displayName) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthError('Please fill in all fields'));
      return;
    }

    if (password.length < 6) {
      emit(AuthError('Password must be at least 6 characters'));
      return;
    }

    emit(AuthLoading());
    try {
      final user = await _authService.signUp(email, password, displayName);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      emit(AuthError('Please enter your email address'));
      return;
    }

    emit(AuthLoading());
    try {
      await _authService.resetPassword(email);
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void clearError() {
    if (state is AuthError) {
      emit(AuthUnauthenticated());
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      final type = json['type'] as String?;
      if (type == 'AuthAuthenticated') {
        final userJson = json['user'] as Map<String, dynamic>?;
        if (userJson != null) {
          return AuthAuthenticated(UserModel.fromJson(userJson));
        }
      }
      return AuthUnauthenticated();
    } catch (_) {
      return AuthUnauthenticated();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is AuthAuthenticated) {
      return {
        'type': 'AuthAuthenticated',
        'user': state.user.toJson(),
      };
    }
    return null;
  }
} 