import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/auth/data/datasources/auth_datasource_impl.dart';
import 'package:teslo_app/features/auth/data/errors/auth_errors.dart';
import 'package:teslo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:teslo_app/features/auth/domain/entities/user_entity.dart';
import 'package:teslo_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:teslo_app/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:teslo_app/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  const AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = "",
  });

  final AuthStatus authStatus;
  final UserEntity? user;
  final String errorMessage;

  AuthState copyWith({
    AuthStatus? authStatus,
    UserEntity? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required this.authRepositoryImpl,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  final AuthRepository authRepositoryImpl;
  final KeyValueStorageService keyValueStorageService;

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepositoryImpl.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error desconocido');
    }
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {
    final String? token = await keyValueStorageService.getKeyValue<String>(
      'token',
    );

    if (token == null) return logout();

    try {
      final user = await authRepositoryImpl.checkAuthStatus(token);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error desconocido');
    }
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  void _setLoggedUser(UserEntity user) async {
    await keyValueStorageService.setKeyValue<String>('token', user.token);

    state = state.copyWith(
      user: user,
      errorMessage: '',
      authStatus: AuthStatus.authenticated,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final KeyValueStorageService keyValueStorageService =
      KeyValueStorageServiceImpl();

  final AuthRepository authRepositoryImpl = AuthRepositoryImpl(
    datasource: AuthDatasourceImpl(),
  );

  return AuthNotifier(
    authRepositoryImpl: authRepositoryImpl,
    keyValueStorageService: keyValueStorageService,
  );
});
