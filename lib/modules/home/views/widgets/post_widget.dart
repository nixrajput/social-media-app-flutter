import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/common/cached_network_image.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_icon_btn.dart';
import 'package:social_media_app/common/primary_text_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final _auth = AuthController.find;
    final _postController = PostController.find;

    return NxElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPostHead(_auth, _postController),
          _buildPostBody(_postController),
          _buildPostFooter(_auth, _postController),
        ],
      ),
    );
  }

  Widget _buildPostHead(AuthController _auth, PostController _postController) =>
      Padding(
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
                    post.owner.avatar == null
                        ? GestureDetector(
                            onTap: () => RouteManagement.goToUserProfileView(
                                post.owner.id),
                            child: NxCircleAssetImage(
                              imgAsset: AssetValues.avatar,
                              radius: Dimens.twenty,
                            ),
                          )
                        : GestureDetector(
                            onTap: () => RouteManagement.goToUserProfileView(
                                post.owner.id),
                            child: NxCircleNetworkImage(
                              imageUrl: post.owner.avatar!.url,
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
                        if (post.owner.id == _auth.profileData.user!.id)
                          ListTile(
                            onTap: () {
                              AppUtils.closeBottomSheet();
                              _postController.deletePost(post.id);
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

  Widget _buildPostBody(PostController _postController) => GestureDetector(
        onDoubleTap: () {
          _postController.toggleLikePost(post.id);
        },
        child: FlutterCarousel.builder(
          itemCount: post.images!.length,
          itemBuilder: (ctx, itemIndex, pageViewIndex) {
            return NxNetworkImage(
              imageUrl: post.images![itemIndex].url,
              imageFit: BoxFit.cover,
            );
          },
          options: CarouselOptions(
            aspectRatio: 1 / 1,
            viewportFraction: 1.0,
            slideIndicator: CircularWaveSlideIndicator(),
          ),
        ),
      );

  Widget _buildPostFooter(
          AuthController _auth, PostController _postController) =>
      Padding(
        padding: Dimens.edgeInsets8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NxIconButton(
                  icon: post.likes.contains(_auth.profileData.user?.id)
                      ? CupertinoIcons.heart_solid
                      : CupertinoIcons.heart,
                  onTap: () {
                    _postController.toggleLikePost(post.id);
                  },
                  iconColor: post.likes.contains(_auth.profileData.user?.id)
                      ? ColorValues.primaryColor
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
            NxTextButton(
              label: 'View All Comments',
              onTap: () {},
              textColor: ColorValues.grayColor,
              fontSize: Dimens.fourteen,
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
