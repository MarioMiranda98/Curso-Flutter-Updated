import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/presentation/widgets/widgets.dart';
import 'package:cinemapedia/src/presentation/providers/providers.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: moviesSlideshow),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: 'Lunes 20',
                  loadNextPage:
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: upComingMovies,
                  title: 'Proximamente',
                  subtitle: 'En este mes',
                  loadNextPage:
                      ref.read(upComingMoviesProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  subtitle: '',
                  loadNextPage:
                      ref.read(popularMoviesProvider.notifier).loadNextPage,
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  subtitle: 'Desde siempre',
                  loadNextPage:
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage,
                ),
                SizedBox(height: 50.0),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
