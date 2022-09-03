import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';

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
            children: [
              AvatarWidget(
                avatar: comment.user.avatar,
                size: Dimens.twenty,
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
                        Text(
                          comment.user.uname,
                          style: AppStyles.style15Bold,
                        ),
                        Dimens.boxWidth4,
                        Text(
                          GetTimeAgo.parse(comment.createdAt),
                          style: AppStyles.style13Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .subtitle1!
                                .color,
                          ),
                        ),
                      ],
                    ),
                    Dimens.boxHeight4,
                    RichText(
                      text: TextSpan(
                          text: comment.comment,
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )),
                    ),
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
