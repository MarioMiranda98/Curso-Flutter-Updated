import 'package:cinemapedia/src/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/src/infrastructure/models/actors/credits_response_model.dart';
import 'package:dio/dio.dart' show Dio, BaseOptions;
import 'package:cinemapedia/src/config/constants/environment.dart';
import 'package:cinemapedia/src/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/src/domain/entities/actor_entity.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {'api_key': Environment.movieDbKey, 'language': 'es-MX'},
  ),
);

class ActorsDatasourceImpl extends ActorsDatasource {
  @override
  Future<List<ActorEntity>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final actorsResponse = CreditsResponseModel.fromJson(response.data);

    final actors =
        actorsResponse.cast
            .map((actor) => ActorMapper.castToEntity(actor))
            .toList();

    return actors;
  }
}
