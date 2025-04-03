import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/src/config/helpers/human_formats.dart';
import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final List<MovieEntity> movies;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    this.title,
    this.subtitle,
    this.loadNextPage,
    required this.movies,
  });

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    scrollController.addListener(loadMore);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void loadMore() async {
    if (widget.loadNextPage == null) return;

    if ((scrollController.position.pixels + 200) >=
        scrollController.position.maxScrollExtent) {
      widget.loadNextPage!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final MovieEntity movie = widget.movies[index];

                return FadeInRight(child: _Slide(movie: movie));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final MovieEntity movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                movie.posterPath,
                width: 150.0,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }

                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          SizedBox(
            width: 150.0,
            child: Text(movie.title, maxLines: 2, style: textStyles.titleSmall),
          ),
          SizedBox(
            width: 150.0,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(width: 3.0),
                Text(
                  '${movie.voteAverage}',
                  style: textStyles.bodyMedium?.copyWith(
                    color: Colors.yellow.shade800,
                  ),
                ),
                Spacer(),
                Text(
                  HumanFormats.formatNumber(movie.popularity),
                  style: textStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Text(title ?? '', style: titleStyle),
          const Spacer(),
          FilledButton.tonal(
            onPressed: () {},
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            child: Text(subtitle ?? ''),
          ),
        ],
      ),
    );
  }
}
