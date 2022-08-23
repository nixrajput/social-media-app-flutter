import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/helpers/utils.dart';

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

    if (post.mediaFiles![0].mediaType == "video") {
      return Stack(
        children: [
          FutureBuilder<File>(
            future: AppUtils.getVideoThumb(post.mediaFiles![0].url!),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Container(
                  width: Dimens.screenWidth,
                  height: Dimens.screenWidth,
                  constraints: BoxConstraints(
                    maxWidth: Dimens.screenWidth,
                    maxHeight: Dimens.screenHeight,
                  ),
                  color: ColorValues.grayColor.withOpacity(0.5),
                );
              }
              if (!data.hasData) {
                return Container(
                  color: ColorValues.grayColor.withOpacity(0.5),
                );
              }
              return Image.file(
                data.data!,
                fit: BoxFit.cover,
                width: Dimens.screenWidth,
                height: Dimens.screenWidth,
              );
            },
          ),
          Positioned(
            bottom: Dimens.four,
            right: Dimens.four,
            child: Icon(
              Icons.play_circle_outline_rounded,
              color: ColorValues.whiteColor,
              size: Dimens.twentyFour,
            ),
          ),
        ],
      );
    }

    return NxNetworkImage(
      imageUrl: post.mediaFiles![0].url!,
    );
  }
}
