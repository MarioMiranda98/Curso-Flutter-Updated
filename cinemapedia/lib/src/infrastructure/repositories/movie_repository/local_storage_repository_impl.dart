import 'package:cinemapedia/src/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  LocalStorageRepositoryImpl({required this.datasource});

  final LocalStorageDatasource datasource;

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limit = 10, int offset = 0}) async {
    return await datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(MovieEntity movie) async {
    datasource.toggleFavorite(movie);
  }
}
