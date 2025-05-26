import 'package:teslo_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);

  Future<UserEntity> register(String email, String password, String fullName);

  Future<UserEntity> checkAuthStatus(String token);
}
