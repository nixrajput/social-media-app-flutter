import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/modules/home/views/widgets/video_player_widget.dart';

class PostThumbnailWidget extends StatelessWidget {
  const PostThumbnailWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    if (post.images != null && post.images!.isNotEmpty) {
      return NxNetworkImage(
        imageUrl: post.images![0].url!,
      );
    }

    return post.mediaFiles![0].mediaType == "video"
        ? NxVideoPlayerWidget(
            url: post.mediaFiles![0].link!.url!,
            showControls: false,
            configuration: const BetterPlayerConfiguration(
              autoPlay: false,
              fit: BoxFit.contain,
              aspectRatio: 1 / 1,
              controlsConfiguration: BetterPlayerControlsConfiguration(
                enableFullscreen: true,
                showControlsOnInitialize: false,
                showControls: false,
              ),
            ),
          )
        : NxNetworkImage(
            imageUrl: post.mediaFiles![0].link!.url!,
          );
  }
}
