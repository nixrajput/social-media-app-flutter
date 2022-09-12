import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/apis/models/entities/post_media_file.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/cached_network_image.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class PostThumbnailWidget extends StatelessWidget {
  const PostThumbnailWidget({
    Key? key,
    required this.mediaFile,
    required this.post,
  }) : super(key: key);

  final PostMediaFile mediaFile;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => RouteManagement.goToPostDetailsView(post.id!, post),
      onLongPress: () => _showHeaderOptionBottomSheet(post),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.eight),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (mediaFile.mediaType == "video") {
      return Stack(
        children: [
          if (mediaFile.thumbnail != null)
            NxNetworkImage(imageUrl: mediaFile.thumbnail!.url!)
          else
            Container(color: ColorValues.blackColor),
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
      imageUrl: mediaFile.url!,
    );
  }

  void _showHeaderOptionBottomSheet(Post post) => AppUtils.showBottomSheet(
        [
          if (post.owner.id == ProfileController.find.profileDetails.user!.id)
            ListTile(
              onTap: () async {
                AppUtils.closeBottomSheet();
                await _showDeletePostOptions(post.id!);
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

  Future<void> _showDeletePostOptions(String id) async {
    AppUtils.showSimpleDialog(
      Padding(
        padding: Dimens.edgeInsets16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringValues.deleteConfirmationText,
              style: AppStyles.style14Normal,
            ),
            Dimens.boxHeight24,
            Row(
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
                    await Get.find<PostController>().deletePost(id);
                  },
                  padding: Dimens.edgeInsets8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
