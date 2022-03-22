import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_indicators.dart';
import 'package:flutter_carousel_widget/flutter_carousel_options.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/common/cached_network_image.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/primary_icon_btn.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/models/post_model.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPostHead(),
        Dimens.boxHeight8,
        _buildPostBody(),
        Dimens.boxHeight8,
        _buildPostFooter(),
      ],
    );
  }

  Widget _buildPostHead() => Padding(
        padding: Dimens.edgeInsets0_8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    post.owner!.avatar == null
                        ? NxCircleAssetImage(
                            imgAsset: AssetValues.avatar,
                            radius: Dimens.twenty,
                          )
                        : NxCircleNetworkImage(
                            imageUrl: post.owner!.avatar!.url,
                            radius: Dimens.twenty,
                          ),
                    Dimens.boxWidth8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          post.owner!.fname + " " + post.owner!.lname,
                          style: AppStyles.style16Bold,
                        ),
                        Text(
                          "@" + post.owner!.uname,
                          style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .subtitle1!
                                .color,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                NxIconButton(
                  icon: CupertinoIcons.chevron_down,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildPostBody() => GestureDetector(
        onDoubleTap: () {
          debugPrint('tapped');
        },
        child: FlutterCarousel(
          options: CarouselOptions(
            height: Dimens.screenWidth * 0.8,
            floatingIndicator: true,
            viewportFraction: 1.0,
            aspectRatio: 1.0,
            slideIndicator: CircularWaveSlideIndicator(),
          ),
          items: post.images!
              .map((img) => NxNetworkImage(
                    imageUrl: img.url,
                  ))
              .toList(),
        ),
      );

  Widget _buildPostFooter() => Padding(
        padding: Dimens.edgeInsets0_8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                NxIconButton(
                  icon: CupertinoIcons.heart,
                  onTap: () {},
                ),
                Dimens.boxWidth8,
                NxIconButton(
                  icon: CupertinoIcons.chat_bubble,
                  onTap: () {},
                ),
              ],
            ),
            Dimens.boxHeight4,
            if (post.caption != null)
              Text(
                post.caption!,
                style: AppStyles.style16Normal,
              ),
            Text(
              GetTimeAgo.parse(post.createdAt!),
              style: TextStyle(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
            const Divider(
              thickness: 0.25,
            ),
          ],
        ),
      );
}
