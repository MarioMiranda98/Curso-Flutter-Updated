import 'package:toktik/domain/entities/video_post_entity.dart';

class LocalVideoModel {
  final String name;
  final String videoUrl;
  final int likes;
  final int views;

  LocalVideoModel({
    required this.name,
    required this.videoUrl,
    this.likes = 0,
    this.views = 0,
  });

  factory LocalVideoModel.fromJson(Map<String, dynamic> json) =>
      LocalVideoModel(
        name: json['name'],
        videoUrl: json['videoUrl'],
        likes: json['likes'],
        views: json['views'],
      );

  VideoPostEntity toVideoPostEntity() => VideoPostEntity(
        caption: name,
        videoUrl: videoUrl,
        likes: likes,
        views: views,
      );
}
