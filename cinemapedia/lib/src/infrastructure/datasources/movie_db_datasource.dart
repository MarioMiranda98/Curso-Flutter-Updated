import 'package:cinemapedia/src/config/constants/environment.dart';
import 'package:cinemapedia/src/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/src/infrastructure/models/movie_db/movie_db_response_model.dart';
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
    final response = await dio.get('/movie/now_playing');
    final movieDbResponse = MovieDbResponseModel.fromJson(response.data);

    final List<MovieEntity> movies =
        movieDbResponse.results
            .where((movie) => movie.posterPath != 'no-poster')
            .map((movie) => MovieMapper.movieDbToEntityMapper(movie))
            .toList();

    return movies;
  }
}
