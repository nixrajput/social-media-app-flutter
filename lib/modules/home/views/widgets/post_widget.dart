import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/global_widgets/elevated_card.dart';
import 'package:social_media_app/global_widgets/expandable_text_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/global_widgets/video_player_widget.dart';
import 'package:social_media_app/helpers/get_time_ago_msg.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_view_widget.dart';
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
                    GestureDetector(
                      onTap: () => RouteManagement.goToUserProfileView(
                        post.owner.id,
                      ),
                      child: AvatarWidget(
                        avatar: post.owner.avatar,
                        size: Dimens.twenty,
                      ),
                    ),
                    Dimens.boxWidth8,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildFullName(),
                        _buildUsername(),
                      ],
                    ),
                  ],
                ),
                NxIconButton(
                  icon: CupertinoIcons.ellipsis_vertical,
                  iconSize: Dimens.twenty,
                  iconColor: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  onTap: _showHeaderOptionBottomSheet,
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildFullName() => GestureDetector(
        onTap: () => RouteManagement.goToUserProfileView(
          post.owner.id,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                text: '${post.owner.fname} ${post.owner.lname}',
                style: AppStyles.style14Bold.copyWith(
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
              ),
              maxLines: 1,
            ),
            if (post.owner.isVerified) Dimens.boxWidth4,
            if (post.owner.isVerified)
              Icon(
                CupertinoIcons.checkmark_seal_fill,
                color: Theme.of(Get.context!).brightness == Brightness.dark
                    ? Theme.of(Get.context!).textTheme.bodyText1?.color
                    : ColorValues.primaryColor,
                size: Dimens.fourteen,
              )
          ],
        ),
      );

  Widget _buildUsername() => GestureDetector(
        onTap: () => RouteManagement.goToUserProfileView(post.owner.id),
        child: Text(
          "@${post.owner.uname}",
          style: TextStyle(
            color: Theme.of(Get.context!).textTheme.subtitle1!.color,
          ),
        ),
      );

  Widget _buildPostBody() {
    var currentItem = 0;
    return StatefulBuilder(builder: (context, setInnerState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onDoubleTap: () => PostController.find.toggleLikePost(post),
            child: FlutterCarousel(
              items: post.mediaFiles!.map(
                (media) {
                  if (media.mediaType == "video") {
                    return Hero(
                      tag: post.id!,
                      child: NxVideoPlayerWidget(
                        url: media.url!,
                        thumbnailUrl: media.thumbnail?.url,
                        isSmallPlayer: true,
                        showControls: true,
                        startVideoWithAudio: true,
                        onTap: () => Get.to(() => PostViewWidget(post: post)),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => Get.to(() => PostViewWidget(post: post)),
                    child: Hero(
                      tag: post.id!,
                      child: NxNetworkImage(
                        imageUrl: media.url!,
                        imageFit: BoxFit.cover,
                        width: Dimens.screenWidth,
                      ),
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                  height: Dimens.screenWidth * 0.75,
                  aspectRatio: 1 / 1,
                  viewportFraction: 1.0,
                  showIndicator: false,
                  onPageChanged: (int index, CarouselPageChangedReason reason) {
                    setInnerState(() {
                      currentItem = index;
                    });
                  }),
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
      );
    });
  }

  Widget _buildPostFooter() => Padding(
        padding: Dimens.edgeInsets0_8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (post.caption != null && post.caption!.isNotEmpty)
              Dimens.boxHeight4,
            if (post.caption != null && post.caption!.isNotEmpty)
              NxExpandableText(
                text: post.caption!,
              ),
            Dimens.dividerWithHeight,
            Padding(
              padding: Dimens.edgeInsets0_4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => RouteManagement.goToPostPostLikedUsersView(
                            post.id!),
                        child: Padding(
                          padding: Dimens.edgeInsets4,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${post.likesCount}'.toCountingFormat(),
                                  style: AppStyles.style14Bold.copyWith(
                                    color: Theme.of(Get.context!)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                                TextSpan(
                                  text: '  Likes',
                                  style: AppStyles.style14Bold.copyWith(
                                    color: Theme.of(Get.context!)
                                        .textTheme
                                        .subtitle1!
                                        .color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Dimens.boxWidth16,
                      GestureDetector(
                        onTap: () =>
                            RouteManagement.goToPostCommentsView(post.id!),
                        child: Padding(
                          padding: Dimens.edgeInsets4,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${post.commentsCount}'
                                      .toCountingFormat(),
                                  style: AppStyles.style14Bold.copyWith(
                                    color: Theme.of(Get.context!)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                                TextSpan(
                                  text: '  Comments',
                                  style: AppStyles.style14Bold.copyWith(
                                    color: Theme.of(Get.context!)
                                        .textTheme
                                        .subtitle1!
                                        .color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildPostTime(),
                ],
              ),
            ),
            Dimens.dividerWithHeight,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => PostController.find.toggleLikePost(post),
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(Get.context!).scaffoldBackgroundColor,
                    radius: Dimens.twenty,
                    child: Icon(
                      post.isLiked ? Icons.favorite : Icons.favorite_outline,
                      color: post.isLiked
                          ? ColorValues.errorColor
                          : ColorValues.grayColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => RouteManagement.goToPostCommentsView(post.id!),
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(Get.context!).scaffoldBackgroundColor,
                    radius: Dimens.twenty,
                    child: const Icon(
                      Icons.messenger_outline,
                      color: ColorValues.grayColor,
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor:
                      Theme.of(Get.context!).scaffoldBackgroundColor,
                  radius: Dimens.twenty,
                  child: const Icon(
                    Icons.bookmark_outline,
                    color: ColorValues.grayColor,
                  ),
                ),
              ],
            ),
            Dimens.boxHeight8,
          ],
        ),
      );

  Widget _buildPostTime() {
    GetTimeAgo.setCustomLocaleMessages('en', CustomMessages());
    return Text(
      GetTimeAgo.parse(
        post.createdAt,
        pattern: 'dd MMM yyyy hh:mm a',
      ),
      style: AppStyles.style12Normal.copyWith(
        color: Theme.of(Get.context!).textTheme.subtitle1!.color,
      ),
    );
  }

  _showHeaderOptionBottomSheet() => AppUtils.showBottomSheet(
        [
          if (post.owner.id == ProfileController.find.profileDetails.user!.id)
            ListTile(
              onTap: () {
                AppUtils.closeBottomSheet();
                _showDeletePostOptions();
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

  Future<void> _showDeletePostOptions() async {
    AppUtils.showSimpleDialog(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Text(
              'Delete',
              style: AppStyles.style18Bold,
            ),
          ),
          Dimens.dividerWithHeight,
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Text(
              StringValues.deleteConfirmationText,
              style: AppStyles.style14Normal,
            ),
          ),
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsets0_16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NxTextButton(
                  label: StringValues.no,
                  labelStyle: AppStyles.style16Bold.copyWith(
                    color: ColorValues.errorColor,
                  ),
                  onTap: AppUtils.closeDialog,
                  padding: Dimens.edgeInsets8,
                ),
                Dimens.boxWidth16,
                NxTextButton(
                  label: StringValues.yes,
                  labelStyle: AppStyles.style16Bold.copyWith(
                    color: ColorValues.successColor,
                  ),
                  onTap: () async {
                    AppUtils.closeDialog();
                    await Get.find<PostController>().deletePost(post.id!);
                  },
                  padding: Dimens.edgeInsets8,
                ),
              ],
            ),
          ),
          Dimens.boxHeight8,
        ],
      ),
    );
  }
}
