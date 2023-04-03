import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/models/entities/profile.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/app_widgets/avatar_widget.dart';
import 'package:social_media_app/app_widgets/circle_border.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/app_widgets/file_image.dart';
import 'package:social_media_app/app_widgets/app_icon_btn.dart';
import 'package:social_media_app/app_widgets/unfocus_widget.dart';
import 'package:social_media_app/app_widgets/video_player_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';
import 'package:social_media_app/utils/file_utility.dart';
import 'package:social_media_app/utils/utility.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = ProfileController.find.profileDetails!.user!;

    return UnFocusWidget(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(profile, context),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NxAppBar _buildAppBar(Profile profile, BuildContext context) {
    return NxAppBar(
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvatarWidget(
              avatar: profile.avatar,
              size: Dimens.twenty,
            ),
            _buildNextBtn(context),
          ],
        ),
      ),
      padding: Dimens.edgeInsetsDefault,
    );
  }

  GestureDetector _buildNextBtn(BuildContext context) {
    return GestureDetector(
      onTap: () => CreatePostController.find.goToPostPreview(),
      child: Container(
        padding: Dimens.edgeInsets8_16,
        decoration: BoxDecoration(
          color: ColorValues.primaryColor,
          borderRadius: BorderRadius.circular(Dimens.four),
        ),
        child: Center(
          child: Text(
            StringValues.next,
            style: AppStyles.style15Bold.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: GetBuilder<CreatePostController>(builder: (logic) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPostPrivacyPicker(context, logic),
            Expanded(
              child: Container(
                color: Theme.of(context).cardColor,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      padding: Dimens.edgeInsetsDefault,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (logic.pickedFileList.isNotEmpty)
                            _buildPostCaption(context, logic),
                          if (logic.pickedFileList.isNotEmpty)
                            _buildMediaPreview(logic, context)
                          else
                            _buildEmptyMedia(context),
                          Dimens.boxHeight16,
                        ],
                      ),
                    ),
                    _buildBottomBarMenu(logic, context),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  _showVisibilityPicker() => AppUtility.showBottomSheet(
        children: StringValues.postVisibilityList2
            .map(
              (e) => GetBuilder<CreatePostController>(
                builder: (logic) {
                  return ListTile(
                    onTap: () {
                      AppUtility.closeBottomSheet();
                      logic.onPostVisibilityChange(e);
                    },
                    title: Text(
                      e['title']!,
                      style: AppStyles.style16Bold,
                    ),
                  );
                },
              ),
            )
            .toList(),
      );

  Widget _buildPostPrivacyPicker(
      BuildContext context, CreatePostController logic) {
    return GestureDetector(
      onTap: _showVisibilityPicker,
      child: Padding(
        padding: Dimens.edgeInsetsDefault,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              logic.postVisibility['title']!,
              style: AppStyles.style14Normal.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            Dimens.boxWidth8,
            Icon(
              Icons.keyboard_arrow_down,
              size: Dimens.twenty,
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildPostCaption(BuildContext context, CreatePostController logic) {
    return Padding(
      padding: Dimens.edgeInsets8_0,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: StringValues.whatsOnYourMind,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: Dimens.edgeInsets0,
        ),
        style: AppStyles.style16Normal.copyWith(
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        scrollPadding: Dimens.edgeInsets0,
        minLines: 1,
        maxLines: 5,
        maxLength: 500,
        buildCounter: (context,
            {currentLength = 0, isFocused = false, maxLength}) {
          return Dimens.shrinkedBox;
        },
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (value) => logic.onChangeCaption(value),
      ),
    );
  }

  Column _buildEmptyMedia(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          StringValues.noImageVideoSelectedWarning,
          style: AppStyles.style32Bold.copyWith(
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMediaPreview(CreatePostController logic, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMediaFiles(logic, context),
        Dimens.boxHeight8,
        _buildPostFileActions(logic, context),
      ],
    );
  }

  Widget _buildMediaFiles(CreatePostController logic, BuildContext context) {
    return FlutterCarousel.builder(
      itemCount: logic.pickedFileList.length,
      itemBuilder: (ctx, itemIndex, pageViewIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.four),
          child: FileUtility.isVideoFile(logic.pickedFileList[itemIndex].path)
              ? NxVideoPlayerWidget(
                  url: logic.pickedFileList[itemIndex].path,
                  showControls: true,
                  startVideoWithAudio: true,
                )
              : NxFileImage(
                  file: logic.pickedFileList[itemIndex],
                ),
        );
      },
      options: CarouselOptions(
        height: Dimens.screenWidth * 0.8,
        aspectRatio: 1 / 1,
        viewportFraction: 1.0,
        showIndicator: true,
        floatingIndicator: false,
        onPageChanged: (index, reason) {
          logic.onChangeFile(index);
        },
        slideIndicator: CircularWaveSlideIndicator(
          indicatorRadius: Dimens.four,
          itemSpacing: Dimens.twelve,
        ),
      ),
    );
  }

  Row _buildPostFileActions(CreatePostController logic, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (FileUtility.isVideoFile(
                logic.pickedFileList[logic.currentFileIndex].path) ==
            false)
          GestureDetector(
            onTap: () => logic.cropImage(logic.currentFileIndex, context),
            child: CircleAvatar(
              radius: Dimens.twenty,
              backgroundColor: Theme.of(context).dividerColor,
              child: Icon(
                Icons.crop,
                size: Dimens.twenty,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        if (FileUtility.isVideoFile(
                logic.pickedFileList[logic.currentFileIndex].path) ==
            false)
          Dimens.boxWidth16,
        GestureDetector(
          onTap: () => logic.removePostFile(logic.currentFileIndex),
          child: CircleAvatar(
            radius: Dimens.twenty,
            backgroundColor: Theme.of(context).dividerColor,
            child: Icon(
              Icons.delete,
              size: Dimens.twenty,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ],
    );
  }

  Positioned _buildBottomBarMenu(
      CreatePostController logic, BuildContext context) {
    return Positioned(
      bottom: Dimens.zero,
      left: Dimens.zero,
      right: Dimens.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dimens.divider,
          Container(
            padding: Dimens.edgeInsets12,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAttachmentBtns(context, logic),
                Dimens.boxWidth16,
                Row(
                  children: [
                    NxCircleBorder(
                      child: Text(
                        logic.caption.length.toString(),
                        style: AppStyles.style12Bold.copyWith(
                          color: Theme.of(context).textTheme.titleMedium!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildAttachmentBtns(
      BuildContext context, CreatePostController logic) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NxCircleBorder(
              child: NxIconButton(
                icon: Icons.photo_library_outlined,
                iconSize: Dimens.twenty,
                iconColor: Theme.of(context).textTheme.bodyLarge!.color,
                onTap: () {
                  if (logic.pickedFileList.length >= 10) {
                    AppUtility.showSnackBar(
                      StringValues.maxImageVideoLimitWarning,
                      StringValues.warning,
                    );
                    return;
                  }

                  logic.selectPostImages();
                },
              ),
            ),
            Dimens.boxWidth32,
            NxCircleBorder(
              child: NxIconButton(
                icon: Icons.video_library_outlined,
                iconSize: Dimens.twenty,
                iconColor: Theme.of(context).textTheme.bodyLarge!.color,
                onTap: () {
                  if (logic.pickedFileList.length >= 10) {
                    AppUtility.showSnackBar(
                      StringValues.maxImageVideoLimitWarning,
                      StringValues.warning,
                    );
                    return;
                  }
                  logic.selectPosVideos();
                },
              ),
            ),
            Dimens.boxWidth32,
            NxCircleBorder(
              child: NxIconButton(
                icon: Icons.camera_alt_outlined,
                iconSize: Dimens.twenty,
                iconColor: Theme.of(context).textTheme.bodyLarge!.color,
                onTap: () {
                  if (logic.pickedFileList.length >= 10) {
                    AppUtility.showSnackBar(
                      StringValues.maxImageVideoLimitWarning,
                      StringValues.warning,
                    );
                    return;
                  }
                  logic.captureImage();
                },
              ),
            ),
            Dimens.boxWidth32,
            NxCircleBorder(
              child: NxIconButton(
                icon: Icons.videocam_outlined,
                iconSize: Dimens.twenty,
                iconColor: Theme.of(context).textTheme.bodyLarge!.color,
                onTap: () {
                  if (logic.pickedFileList.length >= 10) {
                    AppUtility.showSnackBar(
                      StringValues.maxImageVideoLimitWarning,
                      StringValues.warning,
                    );
                    return;
                  }
                  logic.recordVideo();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
