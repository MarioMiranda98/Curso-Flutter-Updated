import 'package:cinemapedia/src/presentation/providers/providers.dart';
import 'package:cinemapedia/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    loadNextPage();
    super.initState();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;

    final movies =
        await ref.read(favoritesMoviesProviders.notifier).loadNextPage();

    isLoading = false;
    isLastPage = movies.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(favoritesMoviesProviders).values.toList();

    if (favoritesMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 60.0,
              color: colors.primary,
            ),
            Text(
              'Ohhh no!',
              style: TextStyle(fontSize: 30.0, color: colors.primary),
            ),
            const Text(
              'No tienes películas favoritas',
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
            const SizedBox(height: 30.0),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: const Text('Empieza a buscar'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(movies: favoritesMovies, loadNextPage: loadNextPage),
    );
  }
}
