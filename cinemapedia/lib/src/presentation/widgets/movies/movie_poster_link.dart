import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {
  const MoviePosterLink({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/0/movie/${movie.id}'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeIn(child: Image.network(movie.posterPath)),
      ),
    );
  }
}
