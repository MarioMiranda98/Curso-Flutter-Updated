import 'package:cinemapedia/src/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/src/domain/entities/actor_entity.dart';
import 'package:cinemapedia/src/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImpl({required this.datasource});

  @override
  Future<List<ActorEntity>> getActorsByMovie(String movieId) async =>
      await datasource.getActorsByMovie(movieId);
}
