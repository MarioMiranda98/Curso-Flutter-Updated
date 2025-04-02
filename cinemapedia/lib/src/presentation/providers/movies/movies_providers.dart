import 'package:cinemapedia/src/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/domain/entities/movie_entity.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<MovieEntity>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

typedef MovieCallback = Future<List<MovieEntity>> Function({int page});

class MoviesNotifier extends StateNotifier<List<MovieEntity>> {
  int currentPage = 0;

  final MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    currentPage += 1;

    final List<MovieEntity> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }
}
