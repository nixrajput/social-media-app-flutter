import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_indicators.dart';
import 'package:flutter_carousel_widget/flutter_carousel_options.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/common/cached_network_image.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
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
    return Container(
      // constraints: BoxConstraints(
      //   maxWidth: Dimens.screenWidth,
      //   maxHeight: Dimens.screenWidth + 16.0,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPostHead(),
          Dimens.boxHeight8,
          _buildPostBody(),
        ],
      ),
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
                    Row(
                      children: [
                        Text(
                          post.owner!.fname + " " + post.owner!.lname,
                          style: AppStyles.style16Bold,
                        ),
                        Dimens.boxWidth4,
                        Text(
                          "•",
                          style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .subtitle1!
                                .color,
                            fontSize: Dimens.twenty,
                          ),
                        ),
                        Dimens.boxWidth4,
                        Text(
                          GetTimeAgo.parse(post.createdAt!).split(',').first,
                          style: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .subtitle1!
                                .color,
                          ),
                        )
                      ],
                    ),
                    Text(
                      "@" + post.owner!.uname,
                      style: TextStyle(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      );

  Widget _buildPostBody() => Column(
        children: [
          FlutterCarousel(
            options: CarouselOptions(
              floatingIndicator: false,
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
          const Divider(
            thickness: 0.25,
          ),
        ],
      );
}
