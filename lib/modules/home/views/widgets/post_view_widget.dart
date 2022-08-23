import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/video_player_widget.dart';

class PostViewWidget extends StatelessWidget {
  const PostViewWidget({
    Key? key,
    this.post,
  }) : super(key: key);

  final Post? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValues.blackColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NxAppBar(
              padding: Dimens.edgeInsets8_16,
              backBtnColor: ColorValues.lightBgColor,
            ),
            Expanded(child: Center(child: _buildBody())),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (post!.images != null && post!.images!.isNotEmpty) {
      return Hero(
        tag: post!.id,
        child: FlutterCarousel(
          items: post!.images!
              .map(
                (img) => NxNetworkImage(
                  imageUrl: img.url!,
                  imageFit: BoxFit.cover,
                  width: Dimens.screenWidth,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: Dimens.screenWidth,
            aspectRatio: 1 / 1,
            viewportFraction: 1.0,
            showIndicator: post!.images!.length > 1 ? true : false,
            floatingIndicator: false,
            slideIndicator: CircularWaveSlideIndicator(
              indicatorBackgroundColor: ColorValues.darkGrayColor,
              currentIndicatorColor: ColorValues.lightBgColor,
            ),
          ),
        ),
      );
    }
    return FlutterCarousel(
      items: post!.mediaFiles!.map(
        (img) {
          if (img.mediaType == "video") {
            return NxVideoPlayerWidget(
              url: img.url!,
            );
          }
          return NxNetworkImage(
            height: Dimens.screenWidth,
            imageUrl: img.url!,
            imageFit: BoxFit.cover,
            width: Dimens.screenWidth,
          );
        },
      ).toList(),
      options: CarouselOptions(
        aspectRatio: 1 / 1,
        viewportFraction: 1.0,
        showIndicator: post!.mediaFiles!.length > 1 ? true : false,
        floatingIndicator: false,
        slideIndicator: CircularWaveSlideIndicator(
          indicatorBackgroundColor: ColorValues.darkGrayColor,
          currentIndicatorColor: ColorValues.lightBgColor,
        ),
      ),
    );
  }
}
