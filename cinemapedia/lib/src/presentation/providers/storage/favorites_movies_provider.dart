import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/src/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesMoviesProviders =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, MovieEntity>>((ref) {
      final LocalStorageRepository localStorageRepository = ref.watch(
        localStorageRepositoryProvider,
      );

      return StorageMoviesNotifier(
        localStorageRepository: localStorageRepository,
      );
    });

class StorageMoviesNotifier extends StateNotifier<Map<int, MovieEntity>> {
  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  int page = 0;
  final LocalStorageRepository localStorageRepository;

  Future<List<MovieEntity>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
      offset: page * 10,
      limit: 20,
    );

    page += 1;

    final tempMap = <int, MovieEntity>{};
    for (final movie in movies) {
      tempMap[movie.id] = movie;
    }

    state = {...state, ...tempMap};
    return movies;
  }

  Future<void> toggleFavorite(MovieEntity movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (!isMovieInFavorites) {
      final aux = {...state};
      aux.remove(movie.id);
      state = {...aux};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
