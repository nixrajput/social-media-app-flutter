import 'package:flutter/material.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/global_widgets/video_player_widget.dart';

class PostThumbnailWidget extends StatelessWidget {
  const PostThumbnailWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.eight),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (post.images != null && post.images!.isNotEmpty) {
      return NxNetworkImage(
        imageUrl: post.images![0].url!,
      );
    }

    return post.mediaFiles![0].mediaType == "video"
        ? Stack(
            children: [
              NxVideoPlayerWidget(
                url: post.mediaFiles![0].url!,
                showControls: false,
              ),
              Positioned(
                bottom: Dimens.four,
                right: Dimens.four,
                child: Icon(
                  Icons.play_circle_outline_rounded,
                  color: ColorValues.whiteColor,
                  size: Dimens.twenty,
                ),
              ),
            ],
          )
        : NxNetworkImage(
            imageUrl: post.mediaFiles![0].url!,
          );
  }
}
