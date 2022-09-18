import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/file_image.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/video_player_widget.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';
import 'package:social_media_app/utils/utility.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NxAppBar(
                  title: StringValues.createNewPost,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight16,
                _buildEditBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditBody() {
    var currentItem = 0;
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: Dimens.edgeInsets0_16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GetBuilder<CreatePostController>(
                builder: (logic) {
                  if (logic.pickedFileList!.isNotEmpty) {
                    return StatefulBuilder(
                      builder: (ctx, setInnerState) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FlutterCarousel.builder(
                            itemCount: logic.pickedFileList!.length,
                            itemBuilder: (ctx, itemIndex, pageViewIndex) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.eight),
                                    child: AppUtility.isVideoFile(logic
                                            .pickedFileList![itemIndex].path)
                                        ? NxVideoPlayerWidget(
                                            url: logic
                                                .pickedFileList![itemIndex]
                                                .path,
                                            showControls: true,
                                            startVideoWithAudio: true,
                                          )
                                        : NxFileImage(
                                            file: logic
                                                .pickedFileList![itemIndex],
                                          ),
                                  ),
                                  Positioned(
                                    top: Dimens.four,
                                    right: Dimens.four,
                                    child: GestureDetector(
                                      onTap: () {
                                        logic.removePostImage(itemIndex);
                                      },
                                      child: CircleAvatar(
                                        radius: Dimens.twenty,
                                        backgroundColor: ColorValues.blackColor
                                            .withOpacity(0.75),
                                        child: Icon(
                                          Icons.delete,
                                          size: Dimens.twenty,
                                          color: ColorValues.lightBgColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            options: CarouselOptions(
                                aspectRatio: 1 / 1,
                                viewportFraction: 1.0,
                                showIndicator: false,
                                onPageChanged: (int index, reason) {
                                  setInnerState(() {
                                    currentItem = index;
                                  });
                                }),
                          ),
                          if (logic.pickedFileList!.length > 1)
                            Dimens.boxHeight8,
                          if (logic.pickedFileList!.length > 1)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  logic.pickedFileList!.asMap().entries.map(
                                (entry) {
                                  return Container(
                                    width: Dimens.eight,
                                    height: Dimens.eight,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: Dimens.two,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(Get.context!)
                                                      .brightness ==
                                                  Brightness.dark
                                              ? ColorValues.whiteColor
                                              : ColorValues.blackColor)
                                          .withOpacity(currentItem == entry.key
                                              ? 0.9
                                              : 0.4),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          if (logic.pickedFileList!.length < 10)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Dimens.boxHeight16,
                                NxIconButton(
                                  icon: Icons.add_circle_outlined,
                                  onTap: logic.selectPostImages,
                                  iconColor: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  iconSize: Dimens.fourtyEight,
                                ),
                              ],
                            ),
                          Dimens.boxHeight40,
                          NxFilledButton(
                            onTap: logic.goToCaptionView,
                            label: StringValues.next.toUpperCase(),
                          ),
                        ],
                      ),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        StringValues.noImageVideoSelectedWarning,
                        style: AppStyles.style32Bold.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Dimens.boxHeight40,
                      NxFilledButton(
                        onTap: _showCreatePostOptions,
                        label: StringValues.select.toUpperCase(),
                      ),
                    ],
                  );
                },
              ),
              Dimens.boxHeight16,
            ],
          ),
        ),
      ),
    );
  }

  _showCreatePostOptions() => AppUtility.showBottomSheet(
        [
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              CreatePostController.find.captureImage();
            },
            leading: const Icon(Icons.camera),
            title: Text(
              StringValues.captureImage,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              CreatePostController.find.recordVideo();
            },
            leading: const Icon(Icons.videocam),
            title: Text(
              StringValues.recordVideo,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              CreatePostController.find.selectPostImages();
            },
            leading: const Icon(Icons.photo_album),
            title: Text(
              StringValues.chooseImages,
              style: AppStyles.style16Bold,
            ),
          ),
          ListTile(
            onTap: () {
              AppUtility.closeBottomSheet();
              CreatePostController.find.selectPosVideos();
            },
            leading: const Icon(Icons.video_collection),
            title: Text(
              StringValues.chooseVideos,
              style: AppStyles.style16Bold,
            ),
          ),
        ],
      );
}
