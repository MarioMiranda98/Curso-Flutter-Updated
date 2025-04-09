import 'package:cinemapedia/src/domain/entities/actor_entity.dart';
import 'package:cinemapedia/src/infrastructure/models/actors/credits_response_model.dart';

class ActorMapper {
  static ActorEntity castToEntity(Cast cast) => ActorEntity(
    id: cast.id,
    name: cast.name,
    profilePath:
        cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
            : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png',
    character: cast.character,
  );
}
