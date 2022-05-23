import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/common/cached_network_image.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_icon_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_like_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/video_player_widget.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class PostDetailsWidget extends StatelessWidget {
  const PostDetailsWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final profile = ProfileController.find;

    return NxElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPostHead(profile),
          _buildPostBody(),
          _buildPostFooter(profile),
        ],
      ),
    );
  }

  Widget _buildPostHead(ProfileController profile) => Padding(
        padding: Dimens.edgeInsets8,
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
                    (post.owner.avatar != null &&
                            post.owner.avatar?.url != null)
                        ? GestureDetector(
                            onTap: () => RouteManagement.goToUserProfileView(
                                post.owner.id),
                            child: NxCircleNetworkImage(
                              imageUrl: post.owner.avatar!.url!,
                              radius: Dimens.twenty,
                            ),
                          )
                        : GestureDetector(
                            onTap: () => RouteManagement.goToUserProfileView(
                                post.owner.id),
                            child: NxCircleAssetImage(
                              imgAsset: AssetValues.avatar,
                              radius: Dimens.twenty,
                            ),
                          ),
                    Dimens.boxWidth8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => RouteManagement.goToUserProfileView(
                              post.owner.id),
                          child: Text(
                            "${post.owner.fname} ${post.owner.lname}",
                            style: AppStyles.style16Bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => RouteManagement.goToUserProfileView(
                              post.owner.id),
                          child: Text(
                            "@${post.owner.uname}",
                            style: TextStyle(
                              color: Theme.of(Get.context!)
                                  .textTheme
                                  .subtitle1!
                                  .color,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                NxIconButton(
                  icon: CupertinoIcons.chevron_down,
                  iconSize: Dimens.twenty,
                  onTap: () {
                    AppUtils.showBottomSheet(
                      [
                        if (post.owner.id == profile.profileData.user!.id)
                          ListTile(
                            onTap: () {
                              AppUtils.closeBottomSheet();
                              Get.find<PostController>().deletePost(post.id);
                            },
                            leading: const Icon(CupertinoIcons.delete),
                            title: Text(
                              StringValues.delete,
                              style: AppStyles.style16Bold,
                            ),
                          ),
                        ListTile(
                          onTap: AppUtils.closeBottomSheet,
                          leading: const Icon(CupertinoIcons.share),
                          title: Text(
                            StringValues.share,
                            style: AppStyles.style16Bold,
                          ),
                        ),
                        ListTile(
                          onTap: AppUtils.closeBottomSheet,
                          leading: const Icon(CupertinoIcons.reply),
                          title: Text(
                            StringValues.report,
                            style: AppStyles.style16Bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildPostBody() {
    if (post.images!.isNotEmpty) {
      return GestureDetector(
        onDoubleTap: () {
          Get.find<PostLikeController>().toggleLikePost(post);
        },
        child: FlutterCarousel(
          items: post.images!
              .map((img) => NxNetworkImage(
                    imageUrl: img.url!,
                    imageFit: BoxFit.cover,
                    width: Dimens.screenWidth,
                    height: Dimens.screenWidth,
                  ))
              .toList(),
          options: CarouselOptions(
            aspectRatio: 1 / 1,
            viewportFraction: 1.0,
            showIndicator: post.images!.length > 1 ? true : false,
            floatingIndicator: false,
            slideIndicator: CircularWaveSlideIndicator(),
          ),
        ),
      );
    }
    return GestureDetector(
      onDoubleTap: () {
        Get.find<PostLikeController>().toggleLikePost(post);
      },
      child: FlutterCarousel(
        items: post.mediaFiles!.map(
          (img) {
            if (img.mediaType == "video") {
              return NxVideoPlayerWidget(
                showFullControls: true,
                url: img.link!.url!,
              );
            }
            return NxNetworkImage(
              imageUrl: img.link!.url!,
              imageFit: BoxFit.cover,
              width: Dimens.screenWidth,
              height: Dimens.screenWidth,
            );
          },
        ).toList(),
        options: CarouselOptions(
          aspectRatio: 1 / 1,
          viewportFraction: 1.0,
          showIndicator: post.mediaFiles!.length > 1 ? true : false,
          floatingIndicator: false,
          slideIndicator: CircularWaveSlideIndicator(),
        ),
      ),
    );
  }

  Widget _buildPostFooter(ProfileController profile) => Padding(
        padding: Dimens.edgeInsets8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<PostLikeController>(
              builder: (con) => Row(
                children: [
                  NxIconButton(
                    icon: post.likes.contains(profile.profileData.user?.id)
                        ? CupertinoIcons.heart_solid
                        : CupertinoIcons.heart,
                    onTap: () {
                      con.toggleLikePost(post);
                    },
                    iconColor: post.likes.contains(profile.profileData.user?.id)
                        ? ColorValues.errorColor
                        : ColorValues.grayColor,
                  ),
                  Dimens.boxWidth4,
                  if (post.likes.isNotEmpty)
                    Text(
                      '${post.likes.length} likes',
                      style: AppStyles.style14Bold,
                    ),
                ],
              ),
            ),
            if (post.caption != null && post.caption!.isNotEmpty)
              Dimens.boxHeight4,
            if (post.caption != null && post.caption!.isNotEmpty)
              Row(
                children: [
                  Text(
                    post.owner.uname,
                    style: AppStyles.style14Bold,
                  ),
                  Dimens.boxWidth4,
                  Text(
                    post.caption!,
                    style: AppStyles.style14Normal,
                  ),
                ],
              ),
            Dimens.boxHeight4,
            Text(
              GetTimeAgo.parse(post.createdAt),
              style: TextStyle(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
            // const Divider(thickness: 0.25),
          ],
        ),
      );
}
