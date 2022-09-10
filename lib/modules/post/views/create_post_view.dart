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
import 'package:social_media_app/global_widgets/video_player_widget.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

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
                const NxAppBar(
                  title: StringValues.createNewPost,
                ),
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
              Dimens.boxHeight16,
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
                              return ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Dimens.eight),
                                child: Stack(
                                  children: [
                                    AppUtils.isVideoFile(logic
                                            .pickedFileList![itemIndex].path)
                                        ? NxVideoPlayerWidget(
                                            url: logic
                                                .pickedFileList![itemIndex]
                                                .path,
                                            showControls: true,
                                          )
                                        : NxFileImage(
                                            file: logic
                                                .pickedFileList![itemIndex],
                                          ),
                                    Positioned(
                                      top: Dimens.eight,
                                      right: Dimens.eight,
                                      child: GestureDetector(
                                        onTap: () {
                                          logic.removePostImage(itemIndex);
                                        },
                                        child: CircleAvatar(
                                          radius: Dimens.twenty,
                                          backgroundColor: ColorValues
                                              .blackColor
                                              .withOpacity(0.75),
                                          child: Icon(
                                            Icons.close,
                                            size: Dimens.twenty,
                                            color: ColorValues.lightBgColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                          Dimens.boxHeight40,
                          NxFilledButton(
                            onTap: RouteManagement.goToAddCaptionView,
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
                        onTap: CreatePostController.find.selectPostImages,
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
}
