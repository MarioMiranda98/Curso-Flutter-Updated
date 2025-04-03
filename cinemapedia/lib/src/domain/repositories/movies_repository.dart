import 'package:cinemapedia/src/domain/entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<List<MovieEntity>> getNowPlaying({int page = 1});

  Future<List<MovieEntity>> getPopularMovies({int page = 1});

  Future<List<MovieEntity>> getUpComingMovies({int page = 1});

  Future<List<MovieEntity>> getTopRatedMovies({int page = 1});
}
