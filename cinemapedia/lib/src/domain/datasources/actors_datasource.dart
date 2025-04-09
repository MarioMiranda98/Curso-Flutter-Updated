import 'package:cinemapedia/src/domain/entities/actor_entity.dart';

abstract class ActorsDatasource {
  Future<List<ActorEntity>> getActorsByMovie(String movieId);
}
