import 'package:cinemapedia/src/config/constants/environment.dart';
import 'package:cinemapedia/src/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/src/infrastructure/models/movie_db/movie_db_response_model.dart';
import 'package:cinemapedia/src/infrastructure/models/movie_db/movie_details_model.dart';
import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {'api_key': Environment.movieDbKey, 'language': 'es-MX'},
  ),
);

class MovieDbDatasource extends MoviesDatasource {
  @override
  Future<List<MovieEntity>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );
    final movieDbResponse = MovieDbResponseModel.fromJson(response.data);

    final List<MovieEntity> movies =
        movieDbResponse.results
            .where((movie) => movie.posterPath != 'no-poster')
            .map((movie) => MovieMapper.movieDbToEntityMapper(movie))
            .toList();

    return movies;
  }

  @override
  Future<List<MovieEntity>> getPopularMovies({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    final movieDbResponse = MovieDbResponseModel.fromJson(response.data);

    final List<MovieEntity> movies =
        movieDbResponse.results
            .where((movie) => movie.posterPath != 'no-poster')
            .map((movie) => MovieMapper.movieDbToEntityMapper(movie))
            .toList();

    return movies;
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovies({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    final movieDbResponse = MovieDbResponseModel.fromJson(response.data);

    final List<MovieEntity> movies =
        movieDbResponse.results
            .where((movie) => movie.posterPath != 'no-poster')
            .map((movie) => MovieMapper.movieDbToEntityMapper(movie))
            .toList();

    return movies;
  }

  @override
  Future<List<MovieEntity>> getUpComingMovies({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    final movieDbResponse = MovieDbResponseModel.fromJson(response.data);

    final List<MovieEntity> movies =
        movieDbResponse.results
            .where((movie) => movie.posterPath != 'no-poster')
            .map((movie) => MovieMapper.movieDbToEntityMapper(movie))
            .toList();

    return movies;
  }

  @override
  Future<MovieEntity> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');

    if (response.statusCode != 200) {
      throw Exception('Movie with Id: $id not found');
    }

    final details = MovieDetailsModel.fromJson(response.data);
    final movie = MovieMapper.movieDetailsToEntity(details);

    return movie;
  }
}
