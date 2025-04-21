import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/src/config/helpers/human_formats.dart';
import 'package:cinemapedia/src/domain/entities/movie_entity.dart';

typedef SearchMoviesCallback = Future<List<MovieEntity>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<MovieEntity?> {
  SearchMovieDelegate({
    required this.searchMoviesCallback,
    required this.initialMovies,
  }) : super(searchFieldLabel: 'Buscar películas');

  final SearchMoviesCallback searchMoviesCallback;
  List<MovieEntity> initialMovies;

  Timer? _debounceTimer;
  StreamController<List<MovieEntity>> debouncedMovies =
      StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  void _clearStream() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  void _onQueryChange(String query) {
    isLoadingStream.sink.add(true);
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMoviesCallback(query);

      debouncedMovies.sink.add(movies);
      initialMovies = movies;
      isLoadingStream.sink.add(false);
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder<bool>(
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;

          return isLoading
              ? SpinPerfect(
                spins: 10,
                duration: Duration(seconds: 10),
                child: IconButton(
                  onPressed: () => query = "",
                  icon: const Icon(Icons.refresh_rounded),
                ),
              )
              : FadeIn(
                animate: query.isNotEmpty,
                duration: Duration(milliseconds: 200),
                child: IconButton(
                  onPressed: () => query = "",
                  icon: const Icon(Icons.clear),
                ),
              );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _clearStream();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);

    return _buildResultsSuggestions();
  }

  Widget _buildResultsSuggestions() {
    return StreamBuilder(
      stream: debouncedMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return _MovieSearchItem(
              movie: movie,
              onMovieSelected: (context, movie) {
                _clearStream();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieSearchItem extends StatelessWidget {
  const _MovieSearchItem({required this.movie, required this.onMovieSelected});

  final MovieEntity movie;
  final void Function(BuildContext context, MovieEntity? movie) onMovieSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            SizedBox(width: 10.0),
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textTheme.titleMedium),

                  movie.overview.length > 100
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),

                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        HumanFormats.formatNumber(movie.voteAverage, 1),
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
