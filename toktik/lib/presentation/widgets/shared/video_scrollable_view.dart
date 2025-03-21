import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post_entity.dart';
import 'package:toktik/presentation/widgets/shared/video_buttons.dart';
import 'package:toktik/presentation/widgets/video/full_screen_player.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPostEntity> videos;

  const VideoScrollableView({
    super.key,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final VideoPostEntity videoPost = videos.elementAt(index);

          return Stack(
            children: [
              SizedBox.expand(
                child: FullScreenPlayer(
                  videoUrl: videoPost.videoUrl,
                  caption: videoPost.caption,
                ),
              ),
              Positioned(
                bottom: 40.0,
                right: 20.0,
                child: VideoButtons(video: videoPost),
              ),
            ],
          );
        });
  }
}
