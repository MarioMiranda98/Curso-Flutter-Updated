import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/domain/entities/actor_entity.dart';
import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/src/presentation/providers/actors/actors_info_provider.dart';
import 'package:cinemapedia/src/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/src/presentation/providers/providers.dart';
import 'package:cinemapedia/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = "movie-screen";

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieInfoProvider);
    final movie = movies[widget.movieId];

    if (movie == null) {
      return Scaffold(
        body: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppbar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movieEntity: movie),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final MovieEntity movieEntity;

  const _MovieDetails({required this.movieEntity});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movieEntity.posterPath,
                  width: mq.size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10.0),
              SizedBox(
                width: (mq.size.width * 0.7) - 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movieEntity.title, style: textStyle.titleLarge),
                    Text(movieEntity.overview),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movieEntity.genreIds.map(
                (genre) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(genre),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _ActorsByMovie(movieId: movieEntity.id.toString()),
        const SizedBox(height: 50.0),
      ],
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose((
  ref,
  int movieId,
) {
  final LocalStorageRepository localStorageRepository = ref.watch(
    localStorageRepositoryProvider,
  );

  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppbar extends ConsumerWidget {
  final MovieEntity movie;

  const _CustomSliverAppbar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final mq = MediaQuery.of(context);

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: mq.size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favoritesMoviesProviders.notifier)
                .toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavoriteFuture.when<Widget>(
            data:
                (value) =>
                    value
                        ? const Icon(Icons.favorite_rounded, color: Colors.red)
                        : const Icon(Icons.favorite_border),
            error: (_, __) => throw UnimplementedError(),
            loading: () => CircularProgressIndicator(),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return SizedBox();

                  return FadeIn(child: child);
                },
              ),
            ),
            CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black54, Colors.transparent],
            ),
            CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black54],
            ),
            CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              stops: [0.0, 0.4],
              colors: [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId];

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors?.length,
        itemBuilder: (context, index) {
          final ActorEntity actor = actors![index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInRight(
                    child: Image.network(
                      actor.profilePath,
                      width: 135.0,
                      height: 180.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
