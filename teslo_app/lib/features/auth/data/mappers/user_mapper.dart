import 'package:teslo_app/features/auth/domain/entities/user_entity.dart';

class UserMapper {
  UserMapper._();

  static UserEntity userJsonToEntity(Map<String, dynamic> json) => UserEntity(
    id: json['id'],
    email: json['email'],
    fullName: json['fullName'],
    roles: List<String>.from(json['roles'].map((role) => role)),
    token: json['token'],
  );
}
