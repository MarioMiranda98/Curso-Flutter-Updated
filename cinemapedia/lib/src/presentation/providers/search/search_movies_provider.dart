import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<MovieEntity>>((ref) {
      final moviesRepositoryProvider = ref.read(movieRepositoryProvider);

      return SearchedMoviesNotifier(
        searchMoviesCallback: moviesRepositoryProvider.searchMovies,
        ref: ref,
      );
    });

typedef SearchMoviesCallback = Future<List<MovieEntity>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<MovieEntity>> {
  SearchedMoviesNotifier({
    required this.searchMoviesCallback,
    required this.ref,
  }) : super([]);

  final SearchMoviesCallback searchMoviesCallback;
  final Ref ref;

  Future<List<MovieEntity>> searchMoviesByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).update((state) => query);
    final List<MovieEntity> movies = await searchMoviesCallback(query);

    state = [...movies];
    return movies;
  }
}
