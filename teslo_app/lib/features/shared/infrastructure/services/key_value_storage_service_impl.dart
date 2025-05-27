import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_app/features/shared/infrastructure/services/key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getKeyValue<T>(String key) async {
    final prefs = await getSharedPreferences();

    switch (T) {
      case const (int):
        prefs.getInt(key) as T?;
        break;
      case const (String):
        prefs.getString(key) as T?;
        break;
      default:
        throw UnimplementedError(
          'Set not implemented for type ${T.runtimeType}}',
        );
    }
    return null;
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPreferences();

    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPreferences();

    switch (T) {
      case const (int):
        await prefs.setInt(key, value as int);
        break;
      case const (String):
        await prefs.setString(key, value as String);
        break;
      default:
        throw UnimplementedError(
          'Set not implemented for type ${T.runtimeType}}',
        );
    }
  }
}
