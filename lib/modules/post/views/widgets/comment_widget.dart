import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/expandable_text_widget.dart';
import 'package:social_media_app/routes/route_management.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimens.edgeInsets0,
      margin: Dimens.edgeInsetsOnlyBottom16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () =>
                    RouteManagement.goToUserProfileView(comment.user.id),
                child: AvatarWidget(
                  avatar: comment.user.avatar,
                  size: Dimens.twentyFour,
                ),
              ),
              Dimens.boxWidth8,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => RouteManagement.goToUserProfileView(
                              comment.user.id),
                          child: Text(
                            comment.user.uname,
                            style: AppStyles.style13Bold,
                          ),
                        ),
                        Dimens.boxWidth4,
                        Container(
                          width: Dimens.four,
                          height: Dimens.four,
                          decoration: BoxDecoration(
                            color: Theme.of(Get.context!).dividerColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Dimens.boxWidth4,
                        Text(
                          GetTimeAgo.parse(comment.createdAt),
                          style: AppStyles.style12Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .subtitle1!
                                .color,
                          ),
                        ),
                      ],
                    ),
                    NxExpandableText(text: comment.comment),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
