import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post_entity.dart';
import 'package:toktik/infrastructure/repositories/video_posts_repository_impl.dart';

class DiscoverProvider extends ChangeNotifier {
  bool initialLoading = true;
  List<VideoPostEntity> videos = [];
  final VideoPostsRepositoryImpl videoPostsRepositoryImpl;

  DiscoverProvider({required this.videoPostsRepositoryImpl});

  Future<void> loadNextPage() async {
    final List<VideoPostEntity> newVideos =
        await videoPostsRepositoryImpl.getTrendingVideosByPage(0);

    videos.addAll(newVideos);
    initialLoading = false;

    notifyListeners();
  }
}
