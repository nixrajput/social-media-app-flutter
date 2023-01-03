import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/elevated_card.dart';
import 'package:social_media_app/global_widgets/expandable_text_widget.dart';
import 'package:social_media_app/global_widgets/get_time_ago_refresh_widget/get_time_ago_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/helpers/get_time_ago_msg.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/post/controllers/comment_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

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
          _buildCommentHead(context),
          _buildCommentBody(context),
          //_buildCommentFooter(context),
          Dimens.boxHeight8,
        ],
      ),
    );
  }

  Widget _buildCommentHead(BuildContext context) => Padding(
        padding: Dimens.edgeInsets8,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => RouteManagement.goToUserProfileView(comment.user.id),
              child: AvatarWidget(
                avatar: comment.user.avatar,
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
                      text: '${comment.user.fname} ${comment.user.lname}',
                      style: AppStyles.style14Bold.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => RouteManagement.goToUserProfileView(
                            comment.user.id),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (comment.user.isVerified)
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
                _buildPostTime(context),
                Dimens.boxWidth4,
                NxIconButton(
                  icon: Icons.more_vert,
                  iconSize: Dimens.sixTeen,
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
      date: comment.createdAt.toLocal(),
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
          text: comment.user.uname,
          style: AppStyles.style13Normal.copyWith(
            color: Theme.of(context).textTheme.subtitle1!.color,
          ),
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Widget _buildCommentBody(BuildContext context) {
    return Padding(
      padding: Dimens.edgeInsets0_8,
      child: NxExpandableText(text: comment.comment),
    );
  }

  // Widget _buildCommentFooter(BuildContext context) => Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         /// Like Button
  //         GestureDetector(
  //           onTap: () => {},
  //           child: Padding(
  //             padding: Dimens.edgeInsets8,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Icon(Icons.favorite_outline,
  //                     size: Dimens.twenty,
  //                     color: Theme.of(context).textTheme.subtitle1!.color),
  //                 Dimens.boxWidth2,
  //                 Text(
  //                   '${0}'.toCountingFormat(),
  //                   style: AppStyles.style13Normal.copyWith(
  //                     color: Theme.of(context).textTheme.subtitle1!.color,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     );

  void _showHeaderOptionBottomSheet(BuildContext context) =>
      AppUtility.showBottomSheet(
        children: [
          if (comment.user.id ==
              ProfileController.find.profileDetails!.user!.id)
            ListTile(
              onTap: () {
                AppUtility.closeBottomSheet();
                _showDeletePostOptions();
              },
              leading: Icon(
                Icons.delete,
                color: Theme.of(context).textTheme.bodyText1!.color,
                size: Dimens.twentyFour,
              ),
              title: Text(
                StringValues.delete,
                style: AppStyles.style16Bold.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
          ListTile(
            onTap: AppUtility.closeBottomSheet,
            leading: Icon(
              Icons.reply,
              color: Theme.of(context).textTheme.bodyText1!.color,
              size: Dimens.twentyFour,
            ),
            title: Text(
              StringValues.reply,
              style: AppStyles.style16Bold.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),
          ListTile(
            onTap: AppUtility.closeBottomSheet,
            leading: Icon(
              Icons.report,
              color: Theme.of(context).textTheme.bodyText1!.color,
              size: Dimens.twentyFour,
            ),
            title: Text(
              StringValues.report,
              style: AppStyles.style16Bold.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
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
              StringValues.delete,
              style: AppStyles.style20Bold,
            ),
          ),
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsetsHorizDefault,
            child: Text(
              StringValues.deleteConfirmationText,
              style: AppStyles.style14Normal,
            ),
          ),
          Dimens.boxHeight8,
          Padding(
            padding: Dimens.edgeInsetsHorizDefault,
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
                    await CommentController.find.deleteComment(comment.id);
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
