import 'dart:io';

import 'package:isar/isar.dart';

import 'package:cinemapedia/src/domain/entities/movie_entity.dart';
import 'package:cinemapedia/src/domain/datasources/local_storage_datasource.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageDatasourceImpl extends LocalStorageDatasource {
  late Future<Isar> database;

  LocalStorageDatasourceImpl() {
    database = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir =
          Platform.isAndroid
              ? await getExternalStorageDirectory()
              : await getApplicationDocumentsDirectory();
      return await Isar.open(
        [MovieEntitySchema],
        inspector: true,
        directory: dir?.path ?? '',
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await database;
    final MovieEntity? movie =
        await isar.movieEntitys.filter().idEqualTo(movieId).findFirst();

    return movie != null;
  }

  @override
  Future<List<MovieEntity>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await database;

    return await isar.movieEntitys
        .where()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  @override
  Future<void> toggleFavorite(MovieEntity movie) async {
    final isar = await database;

    final isFavorite =
        await isar.movieEntitys.filter().idEqualTo(movie.id).findFirst();

    if (isFavorite != null) {
      isar.writeTxnSync(() {
        isar.movieEntitys.deleteSync(movie.isarId!);
      });
    } else {
      isar.writeTxnSync(() {
        isar.movieEntitys.putSync(movie);
      });
    }
  }
}
