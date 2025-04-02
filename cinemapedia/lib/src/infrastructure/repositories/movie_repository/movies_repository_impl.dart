import 'package:cinemapedia/src/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDatasource moviesDatasource;

  MoviesRepositoryImpl({required this.moviesDatasource});

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async =>
      moviesDatasource.getNowPlaying(page: page);
}
