import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/presentation/delegates/search_movie_delegate.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5.0),
              Text('Cinemapedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  // final movieRepositoryProviderWidget = ref.read(
                  //   movieRepositoryProvider,
                  // );
                  final searchQuery = ref.read(searchQueryProvider);

                  final movie = await showSearch<MovieEntity?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: ref.read(searchedMoviesProvider),
                      searchMoviesCallback: (query) async {
                        return await ref
                            .read(searchedMoviesProvider.notifier)
                            .searchMoviesCallback(query);
                      },
                    ),
                  );

                  if (movie != null && context.mounted) {
                    context.push('/movie/${movie.id}');
                  }
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
