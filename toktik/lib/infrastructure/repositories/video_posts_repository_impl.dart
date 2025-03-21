import 'package:toktik/domain/datasource/video_posts_datasource.dart';
import 'package:toktik/domain/entities/video_post_entity.dart';
import 'package:toktik/domain/repositories/video_post_repository.dart';

class VideoPostsRepositoryImpl extends VideoPostsRepository {
  final VideoPostsDatasource videoDatasource;

  VideoPostsRepositoryImpl({
    required this.videoDatasource,
  });

  @override
  Future<List<VideoPostEntity>> getFavoriteVideosByUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoPostEntity>> getTrendingVideosByPage(int page) {
    return videoDatasource.getTrendingVideosByPage(page);
  }
}
