import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/infrastructure/datasources/actors_datasource_impl.dart';
import 'package:cinemapedia/src/infrastructure/repositories/movie_repository/actors_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImpl(datasource: ActorsDatasourceImpl());
});
