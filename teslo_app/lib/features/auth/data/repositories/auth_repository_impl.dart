import 'package:teslo_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_app/features/auth/domain/entities/user_entity.dart';
import 'package:teslo_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.datasource});

  final AuthDatasource datasource;

  @override
  Future<UserEntity> checkAuthStatus(String token) async {
    return await datasource.checkAuthStatus(token);
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    return await datasource.login(email, password);
  }

  @override
  Future<UserEntity> register(
    String email,
    String password,
    String fullName,
  ) async {
    return await datasource.register(email, password, fullName);
  }
}
