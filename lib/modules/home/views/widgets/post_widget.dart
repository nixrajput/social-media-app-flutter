import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/global_widgets/circular_asset_image.dart';
import 'package:social_media_app/global_widgets/circular_network_image.dart';
import 'package:social_media_app/global_widgets/elevated_card.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_like_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/video_player_widget.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return NxElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPostHead(),
          _buildPostBody(),
          Dimens.boxHeight4,
          _buildPostFooter(),
        ],
      ),
    );
  }

  Widget _buildPostHead() => Padding(
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
                            style: AppStyles.style14Bold,
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
                  icon: CupertinoIcons.ellipsis_vertical,
                  iconSize: Dimens.twenty,
                  onTap: () {
                    AppUtils.showBottomSheet(
                      [
                        ListTile(
                          onTap: () {
                            AppUtils.closeBottomSheet();
                            RouteManagement.goToPostDetailsView(post.id, post);
                          },
                          leading: const Icon(CupertinoIcons.eye),
                          title: Text(
                            StringValues.viewPost,
                            style: AppStyles.style16Bold,
                          ),
                        ),
                        if (post.owner.id ==
                            ProfileController.find.profileData.user!.id)
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
    if (post.images != null && post.images!.isNotEmpty) {
      return GestureDetector(
        onDoubleTap: () {
          Get.find<PostLikeController>().toggleLikePost(post);
        },
        child: FlutterCarousel(
          items: post.images!
              .map(
                (img) => NxNetworkImage(
                  imageUrl: img.url!,
                  imageFit: BoxFit.cover,
                  width: Dimens.screenWidth,
                  height: Dimens.screenWidth,
                ),
              )
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

  Widget _buildPostFooter() => Padding(
        padding: Dimens.edgeInsets8_16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<PostLikeController>(
                  builder: (con) => GestureDetector(
                    onTap: () => con.toggleLikePost(post),
                    child: Container(
                      padding: Dimens.edgeInsets8_16,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(Get.context!).dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(Dimens.thirtyTwo),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            post.likes.contains(
                                    ProfileController.find.profileData.user?.id)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: post.likes.contains(
                                    ProfileController.find.profileData.user?.id)
                                ? ColorValues.errorColor
                                : ColorValues.grayColor,
                          ),
                          Dimens.boxWidth8,
                          Text(
                            '${post.likes.length}'.toCountingFormat(),
                            style: AppStyles.style14Normal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      RouteManagement.goToPostDetailsView(post.id, post),
                  child: Container(
                    padding: Dimens.edgeInsets8_16,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(Get.context!).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(Dimens.thirtyTwo),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.messenger_outline,
                          color: ColorValues.grayColor,
                        ),
                        Dimens.boxWidth8,
                        Text(
                          '${post.comments.length}'.toCountingFormat(),
                          style: AppStyles.style14Normal,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: Dimens.edgeInsets8_16,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(Get.context!).dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(Dimens.thirtyTwo),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bookmark_outline,
                        color: ColorValues.grayColor,
                      ),
                      Dimens.boxWidth8,
                      Text(
                        '${0}'.toCountingFormat(),
                        style: AppStyles.style14Normal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Dimens.boxHeight4,
            if (post.caption != null && post.caption!.isNotEmpty)
              Dimens.boxHeight4,
            if (post.caption != null && post.caption!.isNotEmpty)
              Text(
                post.caption!,
                style: AppStyles.style14Normal,
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
