import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/infrastructure/datasources/movie_db_datasource.dart';
import 'package:cinemapedia/src/infrastructure/repositories/movie_repository/movies_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(moviesDatasource: MovieDbDatasource());
});
