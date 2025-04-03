import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/presentation/providers/providers.dart';

final moviesSlideshowProvider = Provider<List<MovieEntity>>((ref) {
  final nowPlayingProvider = ref.watch(nowPlayingMoviesProvider);

  return nowPlayingProvider.isEmpty ? [] : nowPlayingProvider.sublist(0, 6);
});
