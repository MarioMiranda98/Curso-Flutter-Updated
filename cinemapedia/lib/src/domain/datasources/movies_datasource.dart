import 'package:cinemapedia/src/domain/entities/movie_entity.dart';

abstract class MoviesDatasource {
  Future<List<MovieEntity>> getNowPlaying({int page = 1});
}
