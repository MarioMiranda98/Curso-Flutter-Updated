import 'package:cinemapedia/src/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/domain/entities/actor_entity.dart';

final actorsByMovieProvider = StateNotifierProvider((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  final ActorsInfoNotifier actorsInfoNotifier = ActorsInfoNotifier(
    fetchActors: actorsRepository.getActorsByMovie,
  );

  return actorsInfoNotifier;
});

typedef FetchActorsByMovieCallback =
    Future<List<ActorEntity>> Function(String movieId);

class ActorsInfoNotifier extends StateNotifier<Map<String, List<ActorEntity>>> {
  final FetchActorsByMovieCallback fetchActors;

  ActorsInfoNotifier({required this.fetchActors}) : super({});

  void loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await fetchActors(movieId);

    state = {...state, movieId: actors};
  }
}
