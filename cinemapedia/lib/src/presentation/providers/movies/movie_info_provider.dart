import 'package:cinemapedia/src/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/domain/entities/movie_entity.dart';

typedef GetMovieDetailCallback = Future<MovieEntity> Function(String movieId);

final movieInfoProvider = StateNotifierProvider((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  final MovieMapNotifier movieMapNotifier = MovieMapNotifier(
    getMovie: movieRepository.getMovieById,
  );

  return movieMapNotifier;
});

class MovieMapNotifier extends StateNotifier<Map<String, MovieEntity>> {
  final GetMovieDetailCallback getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
