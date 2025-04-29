import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  const MovieMasonry({super.key, this.loadNextPage, required this.movies});

  final List<MovieEntity> movies;
  final VoidCallback? loadNextPage;

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels + 100 >
          scrollController.position.maxScrollExtent) {
        if (widget.loadNextPage != null) widget.loadNextPage!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MasonryGridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        controller: scrollController,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final MovieEntity movie = widget.movies[index];

          if (index == 1) {
            return Column(
              children: [SizedBox(height: 40.0), MoviePosterLink(movie: movie)],
            );
          }

          return MoviePosterLink(movie: movie);
        },
      ),
    );
  }
}
