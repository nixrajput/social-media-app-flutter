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
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NxAppBar(
                padding: Dimens.edgeInsets8_16.copyWith(
                  bottom: Dimens.zero,
                ),
              ),
              Expanded(
                child: Center(
                  child: _buildBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    var currentItem = 0;
    return StatefulBuilder(
      builder: (context, setInnerState) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: post.id!,
            child: FlutterCarousel(
              items: post.mediaFiles!.map(
                (media) {
                  if (media.mediaType == "video") {
                    return NxVideoPlayerWidget(
                      url: media.url!,
                      thumbnailUrl: media.thumbnail?.url,
                      showControls: true,
                      startVideoWithAudio: true,
                    );
                  }
                  return NxNetworkImage(
                    height: Dimens.screenWidth,
                    imageUrl: media.url!,
                    imageFit: BoxFit.cover,
                    width: Dimens.screenWidth,
                  );
                },
              ).toList(),
              options: CarouselOptions(
                aspectRatio: 1 / 1,
                viewportFraction: 1.0,
                showIndicator: false,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  setInnerState(() {
                    currentItem = index;
                  });
                },
              ),
            ),
          ),
          if (post.mediaFiles!.length > 1) Dimens.boxHeight8,
          if (post.mediaFiles!.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: post.mediaFiles!.asMap().entries.map(
                (entry) {
                  return Container(
                    width: Dimens.eight,
                    height: Dimens.eight,
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimens.two,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? ColorValues.whiteColor
                              : ColorValues.blackColor)
                          .withOpacity(currentItem == entry.key ? 0.9 : 0.4),
                    ),
                  );
                },
              ).toList(),
            ),
        ],
      ),
    );
  }
}
