import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/comment.dart';
import 'package:social_media_app/apis/models/entities/user.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_asset_image.dart';
import 'package:social_media_app/global_widgets/circular_network_image.dart';

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
              _buildProfileImage(comment.user),
              Dimens.boxWidth8,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          comment.user.uname,
                          style: AppStyles.style14Bold,
                        ),
                        Dimens.boxWidth8,
                        Text(comment.comment),
                      ],
                    ),
                    Text(
                      GetTimeAgo.parse(comment.createdAt),
                      style: AppStyles.style12Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.subtitle1!.color,
                      ),
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

  Widget _buildProfileImage(User? user) {
    if (user != null && user.avatar != null && user.avatar?.url != null) {
      return NxCircleNetworkImage(
        imageUrl: user.avatar!.url!,
        radius: Dimens.sixTeen,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: Dimens.sixTeen,
    );
  }
}
