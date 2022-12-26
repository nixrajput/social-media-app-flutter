import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/apis/models/entities/poll_option.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/date_extensions.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/global_widgets/elevated_card.dart';
import 'package:social_media_app/global_widgets/expandable_text_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/global_widgets/video_player_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_view_widget.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class PostDetailsWidget extends StatelessWidget {
  const PostDetailsWidget({
    Key? key,
    required this.post,
    required this.controller,
  }) : super(key: key);

  final Post post;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return NxElevatedCard(
      margin: Dimens.edgeInsets8_0,
      borderRadius: Dimens.four,
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

  Widget _buildPostHead(BuildContext context) => Padding(
        padding: Dimens.edgeInsets8,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => RouteManagement.goToUserProfileView(post.owner!.id),
              child: AvatarWidget(
                avatar: post.owner!.avatar,
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
                if (post.owner!.isVerified)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Dimens.boxWidth4,
                      Icon(
                        Icons.verified,
                        color: ColorValues.primaryColor,
                        size: Dimens.sixTeen,
                      ),
                    ],
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
                NxIconButton(
                  icon: Icons.more_vert,
                  iconSize: Dimens.sixTeen,
                  iconColor: Theme.of(context).textTheme.bodyText1!.color,
                  onTap: _showHeaderOptionBottomSheet,
                ),
              ],
            ),
          ),
        ],
      );

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
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: post.pollOptions!
              .map((option) => _buildPollOption(option, context))
              .toList(),
        ),
        Padding(
          padding: Dimens.edgeInsets0_8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${post.totalVotes!.toString().toCountingFormat()} votes',
                style: AppStyles.style13Normal.copyWith(
                  color: Theme.of(context).textTheme.subtitle1!.color,
                ),
              ),
              Dimens.boxHeight4,
              Text(
                '${post.pollEndsAt!.getPollDurationLeft()}',
                style: AppStyles.style13Normal.copyWith(
                  color: post.pollEndsAt!
                          .toLocal()
                          .isBefore(DateTime.now().toLocal())
                      ? Theme.of(context).textTheme.subtitle1!.color
                      : ColorValues.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildPollOption(PollOption option, BuildContext context) {
    var percentage =
        post.totalVotes! > 0 ? (option.votes! / post.totalVotes!) * 100 : 0.0;
    return Container(
      padding: Dimens.edgeInsets8,
      child: Container(
        width: Dimens.screenWidth,
        padding: Dimens.edgeInsets16_12,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        child: Row(
          mainAxisAlignment: post.isVoted!
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                option.option!,
                style: AppStyles.style14Normal.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
            if (post.isVoted!) Dimens.boxWidth4,
            if (post.isVoted!)
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: AppStyles.style14Normal.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
          ],
        ),
      ),
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

  Widget _buildPostFooter(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dimens.boxHeight4,
          Padding(
            padding: Dimens.edgeInsets0_8,
            child: _buildPostTime(context),
          ),
          Padding(
            padding: Dimens.edgeInsets8,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildLikeCount(),
                Dimens.boxWidth16,
                _buildCommentCount(),
                Dimens.boxWidth16,
                _buildRepostCount(),
              ],
            ),
          ),
          Padding(
            padding: Dimens.edgeInsetsDefault,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Like Button
                GestureDetector(
                  onTap: () => controller?.toggleLikePost(post),
                  child: Icon(
                    post.isLiked == true
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    size: Dimens.twenty,
                    color: post.isLiked == true
                        ? ColorValues.errorColor
                        : ColorValues.grayColor,
                  ),
                ),

                /// Comment Button
                GestureDetector(
                  onTap: () => RouteManagement.goToPostCommentsView(post.id!),
                  child: Icon(
                    Icons.comment_outlined,
                    size: Dimens.twenty,
                    color: ColorValues.grayColor,
                  ),
                ),

                /// RePost Button
                Icon(
                  Icons.repeat_outlined,
                  size: Dimens.twenty,
                  color: ColorValues.grayColor,
                ),

                /// Share Button
                Icon(
                  Icons.share_outlined,
                  size: Dimens.twenty,
                  color: ColorValues.grayColor,
                ),
              ],
            ),
          ),
          Dimens.boxHeight8,
        ],
      );

  Widget _buildPostTime(BuildContext context) {
    return Text(
      DateFormat('dd MMM yyyy ∙ hh:mm a').format(post.createdAt!.toLocal()),
      style: AppStyles.style13Normal.copyWith(
        color: Theme.of(context).textTheme.subtitle1!.color,
      ),
    );
  }

  GestureDetector _buildCommentCount() {
    return GestureDetector(
      onTap: () => RouteManagement.goToPostCommentsView(post.id!),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${post.commentsCount}'.toCountingFormat(),
              style: AppStyles.style14Bold.copyWith(
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
            TextSpan(
              text: '  ${StringValues.comments}',
              style: AppStyles.style13Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepostCount() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '0'.toCountingFormat(),
            style: AppStyles.style14Bold.copyWith(
              color: Theme.of(Get.context!).textTheme.bodyText1!.color,
            ),
          ),
          TextSpan(
            text: '  ${StringValues.reposts}',
            style: AppStyles.style13Normal.copyWith(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildLikeCount() {
    return GestureDetector(
      onTap: () => RouteManagement.goToPostPostLikedUsersView(post.id!),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${post.likesCount}'.toCountingFormat(),
              style: AppStyles.style14Bold.copyWith(
                color: Theme.of(Get.context!).textTheme.bodyText1!.color,
              ),
            ),
            TextSpan(
              text: '  ${StringValues.likes}',
              style: AppStyles.style13Normal.copyWith(
                color: Theme.of(Get.context!).textTheme.subtitle1!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showHeaderOptionBottomSheet() => AppUtility.showBottomSheet(
        children: [
          if (post.owner!.id == ProfileController.find.profileDetails!.user!.id)
            ListTile(
              onTap: () {
                AppUtility.closeBottomSheet();
                _showDeletePostOptions();
              },
              leading: const Icon(CupertinoIcons.delete),
              title: Text(
                StringValues.delete,
                style: AppStyles.style16Bold,
              ),
            ),
          ListTile(
            onTap: AppUtility.closeBottomSheet,
            leading: const Icon(CupertinoIcons.share),
            title: Text(
              StringValues.share,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: AppUtility.closeBottomSheet,
            leading: const Icon(CupertinoIcons.reply),
            title: Text(
              StringValues.report,
              style: AppStyles.style16Bold,
            ),
          ),
        ],
      );

  Future<void> _showDeletePostOptions() async {
    AppUtility.showSimpleDialog(
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
                  onTap: AppUtility.closeDialog,
                  padding: Dimens.edgeInsets8,
                ),
                Dimens.boxWidth16,
                NxTextButton(
                  label: StringValues.yes,
                  labelStyle: AppStyles.style16Bold.copyWith(
                    color: ColorValues.successColor,
                  ),
                  onTap: () async {
                    AppUtility.closeDialog();
                    controller?.deletePost(post.id!);
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
