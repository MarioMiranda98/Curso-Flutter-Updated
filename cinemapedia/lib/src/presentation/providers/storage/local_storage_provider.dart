import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/infrastructure/datasources/local_storage_datasource_impl.dart';
import 'package:cinemapedia/src/infrastructure/repositories/movie_repository/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasource: LocalStorageDatasourceImpl());
});
