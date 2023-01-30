import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/date_extensions.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/expandable_text_widget.dart';
import 'package:social_media_app/global_widgets/get_time_ago_refresh_widget/get_time_ago_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/verified_widget.dart';
import 'package:social_media_app/global_widgets/video_player_widget.dart';
import 'package:social_media_app/helpers/get_time_ago_msg.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/home/controllers/trending_post_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_view_widget.dart';
import 'package:social_media_app/modules/post/controllers/post_details_controller.dart';
import 'package:social_media_app/modules/post/views/widgets/poll_option_widget.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.post,
    required this.controller,
  }) : super(key: key);

  final dynamic controller;
  final Post post;

  Widget _buildPostHead(BuildContext context) {
    var profile = ProfileController.find.profileDetails!.user!;
    var avatar =
        post.owner!.id == profile.id ? profile.avatar : post.owner!.avatar;
    return Padding(
      padding: Dimens.edgeInsets8,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => RouteManagement.goToUserProfileView(post.owner!.id),
            child: AvatarWidget(
              avatar: avatar,
              size: Dimens.twenty,
            ),
          ),
          Dimens.boxWidth8,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFullName(context),
                _buildUsername(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullName(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: '${post.owner!.fname} ${post.owner!.lname}',
                      style: AppStyles.style14Bold.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            RouteManagement.goToUserProfileView(post.owner!.id),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (post.owner!.isVerified) Dimens.boxWidth4,
                if (post.owner!.isVerified)
                  VerifiedWidget(
                    verifiedCategory: post.owner!.verifiedCategory!,
                    size: Dimens.fourteen,
                  ),
              ],
            ),
          ),
          Flexible(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Dimens.boxWidth12,
                _buildPostTime(context),
                Dimens.boxWidth4,
                NxIconButton(
                  icon: Icons.more_vert,
                  iconSize: Dimens.twenty,
                  iconColor: Theme.of(context).textTheme.bodyText1!.color,
                  onTap: () => _showHeaderOptionBottomSheet(context),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildPostTime(BuildContext context) {
    GetTimeAgo.setCustomLocaleMessages('en', CustomMessages());
    return GetTimeAgoWidget(
      date: post.createdAt!.toLocal(),
      pattern: 'dd MMM yy',
      builder: (BuildContext context, String value) => Text(
        value,
        style: AppStyles.style12Normal.copyWith(
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
      ),
    );
  }

  Widget _buildUsername(BuildContext context) => RichText(
        text: TextSpan(
          text: post.owner!.uname,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.subtitle1!.color,
          ),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget _buildPostBody(BuildContext context) {
    if (post.postType == 'poll') {
      return _buildPoll(context);
    }

    return _buildPostMedia(context);
  }

  Column _buildPoll(BuildContext context) {
    var isExpired =
        post.pollEndsAt!.toLocal().isBefore(DateTime.now().toLocal());

    String? greatestPercentageId = post.pollOptions!.first.id!;
    var highestVotes = post.pollOptions!.first.votes!;

    for (var i = 1; i < post.pollOptions!.length; i++) {
      if (post.pollOptions![i].votes! > highestVotes) {
        greatestPercentageId = post.pollOptions![i].id!;
      }

      if (post.pollOptions![i].votes! == highestVotes) {
        greatestPercentageId = null;
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (post.pollQuestion != null && post.pollQuestion!.isNotEmpty)
          Padding(
            padding: Dimens.edgeInsets8.copyWith(
              top: Dimens.zero,
              bottom: Dimens.zero,
            ),
            child: NxExpandableText(text: post.pollQuestion!),
          ),
        Dimens.boxHeight4,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: post.pollOptions!
              .map(
                (option) => PollOptionWidget(
                  post: post,
                  option: option,
                  isExpired: isExpired,
                  greatestPercentageId: greatestPercentageId,
                  onTap: () {
                    if (isExpired) return;

                    if (post.isVoted!) return;

                    controller?.voteToPoll(post, option.id!);
                  },
                ),
              )
              .toList(),
        ),
        Dimens.boxHeight8,
        Padding(
          padding: Dimens.edgeInsets0_8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${post.totalVotes!.toString().toCountingFormat()} votes',
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
              Dimens.boxHeight8,
              Text(
                '${post.pollEndsAt!.getPollDurationLeft()}',
                style: AppStyles.style13Normal.copyWith(
                  color: isExpired
                      ? Theme.of(context).textTheme.subtitle1!.color
                      : ColorValues.linkColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildPostMedia(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (post.caption != null && post.caption!.isNotEmpty) _buildCaption(),
        GestureDetector(
          onDoubleTap: () => controller?.toggleLikePost(post),
          child: FlutterCarousel(
            items: post.mediaFiles!.map(
              (media) {
                if (media.mediaType == "video") {
                  return NxVideoPlayerWidget(
                    url: media.url!,
                    thumbnailUrl: media.thumbnail?.url,
                    isSmallPlayer: true,
                    showControls: true,
                    startVideoWithAudio: true,
                    onTap: () => Get.to(() => PostViewWidget(post: post)),
                  );
                }
                return GestureDetector(
                  onTap: () => Get.to(() => PostViewWidget(post: post)),
                  child: NxNetworkImage(
                    imageUrl: media.url!,
                    imageFit: BoxFit.cover,
                    width: Dimens.screenWidth,
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              height: Dimens.screenWidth * 0.75,
              aspectRatio: 1 / 1,
              viewportFraction: 1.0,
              showIndicator: true,
              floatingIndicator: false,
              slideIndicator: CircularWaveSlideIndicator(
                indicatorRadius: Dimens.four,
                itemSpacing: Dimens.twelve,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildCaption() {
    return Padding(
      padding: Dimens.edgeInsets8.copyWith(
        top: Dimens.zero,
      ),
      child: NxExpandableText(text: post.caption!),
    );
  }

  Widget _buildPostFooter(BuildContext context) => Padding(
        padding: Dimens.edgeInsetsHorizDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Like Button
                GestureDetector(
                  onTap: () => controller?.toggleLikePost(post),
                  child: Padding(
                    padding: Dimens.edgeInsets8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          post.isLiked == true
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          size: Dimens.twenty,
                          color: post.isLiked == true
                              ? ColorValues.primaryColor
                              : Theme.of(context).textTheme.subtitle1!.color,
                        ),
                        Dimens.boxWidth2,
                        Text(
                          '${post.likesCount}'.toCountingFormat(),
                          style: AppStyles.style13Normal.copyWith(
                            color: post.isLiked == true
                                ? ColorValues.primaryColor
                                : Theme.of(context).textTheme.subtitle1!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Comment Button
                GestureDetector(
                  onTap: () => RouteManagement.goToPostCommentsView(post.id!),
                  child: Padding(
                    padding: Dimens.edgeInsets8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.comment_outlined,
                          size: Dimens.twenty,
                          color: Theme.of(context).textTheme.subtitle1!.color,
                        ),
                        Dimens.boxWidth2,
                        Text(
                          '${post.commentsCount}'.toCountingFormat(),
                          style: AppStyles.style13Normal.copyWith(
                            color: Theme.of(context).textTheme.subtitle1!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// RePost Button
                Padding(
                  padding: Dimens.edgeInsets8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.repeat_outlined,
                        size: Dimens.twenty,
                        color: Theme.of(context).textTheme.subtitle1!.color,
                      ),
                      Dimens.boxWidth2,
                      Text(
                        '${0}'.toCountingFormat(),
                        style: AppStyles.style13Normal.copyWith(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Share Button
                Padding(
                  padding: Dimens.edgeInsets8,
                  child: Icon(
                    Icons.share_outlined,
                    size: Dimens.twenty,
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  void _showHeaderOptionBottomSheet(BuildContext context) {
    final currentUser = ProfileController.find.profileDetails!.user!;
    AppUtility.showBottomSheet(
      children: [
        /// View Post

        NxListTile(
          bgColor: ColorValues.transparent,
          padding: Dimens.edgeInsets12,
          showBorder: false,
          onTap: () {
            AppUtility.closeBottomSheet();
            RouteManagement.goToPostDetailsView(post.id!, post);
          },
          leading: Icon(
            Icons.visibility,
            color: Theme.of(context).textTheme.bodyText1!.color,
            size: Dimens.twenty,
          ),
          title: Text(
            StringValues.view,
            style: AppStyles.style16Normal.copyWith(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),

        /// Delete Post

        if (post.owner!.id == currentUser.id)
          NxListTile(
            bgColor: ColorValues.transparent,
            padding: Dimens.edgeInsets12,
            showBorder: false,
            onTap: () {
              AppUtility.closeBottomSheet();
              AppUtility.showDeleteDialog(
                context,
                () async {
                  AppUtility.closeDialog();
                  controller?.deletePost(post.id!);
                },
              );
            },
            leading: Icon(
              Icons.delete,
              color: Theme.of(context).textTheme.bodyText1!.color,
              size: Dimens.twenty,
            ),
            title: Text(
              StringValues.delete,
              style: AppStyles.style16Normal.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),

        /// Edit Post

        if (post.owner!.id == currentUser.id)
          NxListTile(
            bgColor: ColorValues.transparent,
            padding: Dimens.edgeInsets12,
            showBorder: false,
            onTap: () {
              AppUtility.closeBottomSheet();
              debugPrint('Edit Post');
              //RouteManagement.goToEditPostView(post);
            },
            leading: Icon(
              Icons.edit,
              color: Theme.of(context).textTheme.bodyText1!.color,
              size: Dimens.twenty,
            ),
            title: Text(
              StringValues.edit,
              style: AppStyles.style16Normal.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),

        /// Share Post

        NxListTile(
          bgColor: ColorValues.transparent,
          padding: Dimens.edgeInsets12,
          showBorder: false,
          onTap: () {
            AppUtility.closeBottomSheet();
            AppUtility.showShareDialog(
              context,
              '${StringValues.websiteUrl}/post/${post.id}',
            );
          },
          leading: Icon(
            Icons.share,
            color: Theme.of(context).textTheme.bodyText1!.color,
            size: Dimens.twenty,
          ),
          title: Text(
            StringValues.share,
            style: AppStyles.style16Normal.copyWith(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),

        /// Report Post

        NxListTile(
          bgColor: ColorValues.transparent,
          padding: Dimens.edgeInsets12,
          showBorder: false,
          onTap: () {
            AppUtility.closeBottomSheet();
            RouteManagement.goToReportIssueView(post.id!);
          },
          leading: Icon(
            Icons.report,
            color: Theme.of(context).textTheme.bodyText1!.color,
            size: Dimens.twenty,
          ),
          title: Text(
            StringValues.report,
            style: AppStyles.style16Normal.copyWith(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(controller is PostDetailsController ||
        controller is PostController ||
        controller is TrendingPostController);
    return Container(
      margin: Dimens.edgeInsets8_0,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.circular(Dimens.four),
        boxShadow: AppStyles.defaultShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPostHead(context),
          _buildPostBody(context),
          Dimens.boxHeight4,
          _buildPostFooter(context),
        ],
      ),
    );
  }
}
