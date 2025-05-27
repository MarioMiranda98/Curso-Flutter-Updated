import 'package:dio/dio.dart';
import 'package:teslo_app/config/constants/environment.dart';
import 'package:teslo_app/features/auth/data/errors/auth_errors.dart';
import 'package:teslo_app/features/auth/data/mappers/user_mapper.dart';
import 'package:teslo_app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_app/features/auth/domain/entities/user_entity.dart';

class AuthDatasourceImpl extends AuthDatasource {
  AuthDatasourceImpl({Dio? dio})
    : dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  final Dio dio;

  @override
  Future<UserEntity> checkAuthStatus(String token) async {
    try {
      final response = await dio.get(
        '/auth/check-status',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final UserEntity user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(message: 'Token incorrecto');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(message: 'Revisar conexión a internet');
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final UserEntity user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
          message: e.response?.data['message'] ?? 'Credenciales incorrectas',
        );
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(message: 'Revisar conexión a internet');
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UserEntity> register(String email, String password, String fullName) {
    throw UnimplementedError();
  }
}
