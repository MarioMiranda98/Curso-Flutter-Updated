import 'package:cinemapedia/src/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDatasource moviesDatasource;

  MoviesRepositoryImpl({required this.moviesDatasource});

  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async =>
      await moviesDatasource.getNowPlaying(page: page);

  @override
  Future<List<MovieEntity>> getPopularMovies({int page = 1}) async =>
      await moviesDatasource.getPopularMovies(page: page);

  @override
  Future<List<MovieEntity>> getTopRatedMovies({int page = 1}) async =>
      await moviesDatasource.getTopRatedMovies(page: page);

  @override
  Future<List<MovieEntity>> getUpComingMovies({int page = 1}) async =>
      await moviesDatasource.getUpComingMovies(page: page);
}
