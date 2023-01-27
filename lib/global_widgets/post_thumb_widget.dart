import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class PostThumbnailWidget extends StatelessWidget {
  const PostThumbnailWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => RouteManagement.goToPostDetailsView(post.id!, post),
      onLongPress: () => _showHeaderOptionBottomSheet(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.four),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (post.postType! == "poll") {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.poll_outlined,
              size: Dimens.thirtyTwo,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            Dimens.boxHeight4,
            Text(
              StringValues.poll,
              style: AppStyles.style16Bold,
            ),
          ],
        ),
      );
    }

    if (post.mediaFiles!.first.mediaType == "video") {
      return Stack(
        children: [
          if (post.mediaFiles!.first.thumbnail != null)
            NxNetworkImage(imageUrl: post.mediaFiles!.first.thumbnail!.url!)
          else
            Container(color: Theme.of(context).dividerColor),
          Positioned(
            bottom: Dimens.four,
            right: Dimens.four,
            child: Icon(
              Icons.play_circle_outline_rounded,
              color: ColorValues.whiteColor,
              size: Dimens.twentyFour,
            ),
          ),
        ],
      );
    }

    return NxNetworkImage(
      imageUrl: post.mediaFiles!.first.url!,
    );
  }

  void _showHeaderOptionBottomSheet(BuildContext context) =>
      AppUtility.showBottomSheet(
        children: [
          if (post.owner!.id == ProfileController.find.profileDetails!.user!.id)
            ListTile(
              onTap: () {
                AppUtility.closeBottomSheet();
                AppUtility.showDeleteDialog(
                  context,
                  () async {
                    AppUtility.closeDialog();
                    await Get.find<PostController>().deletePost(post.id!);
                  },
                );
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
              Icons.share,
              color: Theme.of(context).textTheme.bodyText1!.color,
              size: Dimens.twentyFour,
            ),
            title: Text(
              StringValues.share,
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
}
