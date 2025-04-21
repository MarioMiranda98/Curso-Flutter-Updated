import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/infrastructure/models/movie_db/movie_db_model.dart';
import 'package:cinemapedia/src/infrastructure/models/movie_db/movie_details_model.dart';

class MovieMapper {
  static MovieEntity movieDbToEntityMapper(MovieDbModel movie) => MovieEntity(
    adult: movie.adult,
    backdropPath:
        movie.backdropPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'
            : 'https://ih1.redbubble.net/image.4905811447.8675/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
    genreIds: movie.genreIds.map((e) => e.toString()).toList(),
    id: movie.id,
    originalLanguage: movie.originalLanguage,
    originalTitle: movie.originalTitle,
    overview: movie.overview,
    popularity: movie.popularity,
    posterPath:
        movie.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
            : 'https://ih1.redbubble.net/image.4905811447.8675/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
    releaseDate: movie.releaseDate ?? DateTime.now(),
    title: movie.title,
    video: movie.video,
    voteAverage: movie.voteAverage,
    voteCount: movie.voteCount,
  );

  static MovieEntity movieDetailsToEntity(
    MovieDetailsModel movie,
  ) => MovieEntity(
    adult: movie.adult,
    backdropPath:
        movie.backdropPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'
            : 'https://ih1.redbubble.net/image.4905811447.8675/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
    genreIds: movie.genres.map((e) => e.name).toList(),
    id: movie.id,
    originalLanguage: movie.originalLanguage,
    originalTitle: movie.originalTitle,
    overview: movie.overview,
    popularity: movie.popularity,
    posterPath:
        movie.posterPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
            : 'https://ih1.redbubble.net/image.4905811447.8675/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
    releaseDate: movie.releaseDate,
    title: movie.title,
    video: movie.video,
    voteAverage: movie.voteAverage,
    voteCount: movie.voteCount,
  );
}
