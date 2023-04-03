import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/app_widgets/avatar_widget.dart';
import 'package:social_media_app/app_widgets/expandable_text_widget.dart';
import 'package:social_media_app/app_widgets/get_time_ago_refresh_widget/get_time_ago_widget.dart';
import 'package:social_media_app/app_widgets/app_icon_btn.dart';
import 'package:social_media_app/app_widgets/verified_widget.dart';
import 'package:social_media_app/helpers/get_time_ago_msg.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/post/controllers/comment_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  Widget _buildCommentHead(BuildContext context) => Padding(
        padding: Dimens.edgeInsets8,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => RouteManagement.goToUserProfileDetailsViewByUserId(
                  comment.user!.id),
              child: AvatarWidget(
                avatar: comment.user!.avatar,
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
                      text: '${comment.user!.fname} ${comment.user!.lname}',
                      style: AppStyles.style14Bold.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            RouteManagement.goToUserProfileDetailsViewByUserId(
                                comment.user!.id),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (comment.user!.isVerified) Dimens.boxWidth4,
                if (comment.user!.isVerified)
                  VerifiedWidget(
                    verifiedCategory: comment.user!.verifiedCategory!,
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
                  iconSize: Dimens.sixTeen,
                  iconColor: Theme.of(context).textTheme.bodyLarge!.color,
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
      date: comment.createdAt!.toLocal(),
      pattern: 'dd MMM yy',
      builder: (BuildContext context, String value) => Text(
        value,
        style: AppStyles.style12Normal.copyWith(
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
      ),
    );
  }

  Widget _buildUsername(BuildContext context) => RichText(
        text: TextSpan(
          text: comment.user!.uname,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget _buildCommentBody(BuildContext context) {
    return Padding(
      padding: Dimens.edgeInsets0_8,
      child: NxExpandableText(text: comment.comment!),
    );
  }

  Widget _buildCommentFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// Like Button
        GestureDetector(
          onTap: () => {},
          child: Padding(
            padding: Dimens.edgeInsets8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  comment.isLiked == true
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  size: Dimens.twenty,
                  color: comment.isLiked == true
                      ? ColorValues.primaryColor
                      : Theme.of(context).textTheme.titleMedium!.color,
                ),
                Dimens.boxWidth2,
                Text(
                  '${comment.likesCount}'.toCountingFormat(),
                  style: AppStyles.style13Normal.copyWith(
                    color: comment.isLiked == true
                        ? ColorValues.primaryColor
                        : Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Comment Button
        GestureDetector(
          onTap: () => {},
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
                  color: Theme.of(context).textTheme.titleMedium!.color,
                ),
                Dimens.boxWidth2,
                Text(
                  '${comment.repliesCount!}'.toCountingFormat(),
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showHeaderOptionBottomSheet(BuildContext context) =>
      AppUtility.showBottomSheet(
        children: [
          if (comment.user!.id ==
              ProfileController.find.profileDetails!.user!.id)
            ListTile(
              onTap: () {
                AppUtility.closeBottomSheet();
                _showDeletePostOptions(context);
              },
              leading: Icon(
                Icons.delete,
                color: Theme.of(context).textTheme.bodyLarge!.color,
                size: Dimens.twentyFour,
              ),
              title: Text(
                StringValues.delete,
                style: AppStyles.style16Bold.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ),
          ListTile(
            onTap: AppUtility.closeBottomSheet,
            leading: Icon(
              Icons.reply,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              size: Dimens.twentyFour,
            ),
            title: Text(
              StringValues.reply,
              style: AppStyles.style16Bold.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          ListTile(
            onTap: AppUtility.closeBottomSheet,
            leading: Icon(
              Icons.report,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              size: Dimens.twentyFour,
            ),
            title: Text(
              StringValues.report,
              style: AppStyles.style16Bold.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        ],
      );

  Future<void> _showDeletePostOptions(BuildContext context) async {
    AppUtility.showDeleteDialog(
      context,
      () async {
        AppUtility.closeDialog();
        await CommentController.find.deleteComment(comment.id!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Dimens.edgeInsets8_0,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimens.four),
        boxShadow: AppStyles.defaultShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCommentHead(context),
          _buildCommentBody(context),
          _buildCommentFooter(context),
          Dimens.boxHeight8,
        ],
      ),
    );
  }
}
