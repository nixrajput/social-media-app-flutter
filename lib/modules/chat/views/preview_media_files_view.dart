import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/file_image.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/video_player_widget.dart';
import 'package:social_media_app/modules/chat/controllers/p2p_chat_controller.dart';
import 'package:social_media_app/utils/file_utility.dart';

class PreviewMediaFilesView extends StatelessWidget {
  const PreviewMediaFilesView({super.key});

  @override
  Widget build(BuildContext context) {
    var currentItem = 0;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            child: GetBuilder<P2PChatController>(
              builder: (logic) {
                return Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: Dimens.edgeInsets8_16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NxIconButton(
                                icon: Icons.arrow_back,
                                iconColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                onTap: Get.back,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  NxIconButton(
                                    icon: Icons.delete,
                                    iconColor: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    onTap: () => logic.removeFile(currentItem),
                                  ),
                                  Dimens.boxWidth8,
                                  NxIconButton(
                                    icon: Icons.crop,
                                    iconColor: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Dimens.boxHeight16,
                        Expanded(
                          child: StatefulBuilder(
                            builder: (ctx, setInnerState) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (logic.mediaFileMessages!.length > 1)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: logic.mediaFileMessages!
                                          .asMap()
                                          .entries
                                          .map(
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
                                                  .withOpacity(
                                                      currentItem == entry.key
                                                          ? 0.9
                                                          : 0.4),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  if (logic.mediaFileMessages!.length > 1)
                                    Dimens.boxHeight16,
                                  Expanded(
                                    child: FlutterCarousel.builder(
                                      itemCount:
                                          logic.mediaFileMessages!.length,
                                      itemBuilder:
                                          (ctx, itemIndex, pageViewIndex) {
                                        return Stack(
                                          children: [
                                            FileUtility.isVideoFile(logic
                                                    .mediaFileMessages![
                                                        itemIndex]
                                                    .file
                                                    .path)
                                                ? NxVideoPlayerWidget(
                                                    url: logic
                                                        .mediaFileMessages![
                                                            itemIndex]
                                                        .file
                                                        .path,
                                                    showControls: true,
                                                    startVideoWithAudio: true,
                                                  )
                                                : NxFileImage(
                                                    file: logic
                                                        .mediaFileMessages![
                                                            itemIndex]
                                                        .file,
                                                    fit: BoxFit.contain,
                                                  ),
                                            Positioned(
                                              bottom: Dimens.zero,
                                              left: Dimens.zero,
                                              right: Dimens.zero,
                                              child: Container(
                                                color: Theme.of(Get.context!)
                                                    .dialogTheme
                                                    .backgroundColor,
                                                width: Dimens.screenWidth,
                                                height: Dimens.fourtyEight,
                                                padding: Dimens.edgeInsets0_8,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        onChanged: (value) {
                                                          setInnerState(() {
                                                            logic
                                                                .mediaFileMessages![
                                                                    itemIndex]
                                                                .message = value;
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: StringValues
                                                              .addCaption,
                                                          hintStyle: AppStyles
                                                              .style14Normal
                                                              .copyWith(
                                                            color: Theme.of(Get
                                                                    .context!)
                                                                .textTheme
                                                                .subtitle1!
                                                                .color,
                                                          ),
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                        minLines: 1,
                                                        maxLines: 5,
                                                        style: AppStyles
                                                            .style14Normal
                                                            .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .color,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      options: CarouselOptions(
                                        height: Dimens.screenHeight * 0.75,
                                        viewportFraction: 1.0,
                                        showIndicator: false,
                                        onPageChanged: (int index, reason) {
                                          setInnerState(() {
                                            currentItem = index;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Dimens.boxHeight20,
                      ],
                    ),
                    Positioned(
                      bottom: Dimens.zero,
                      right: Dimens.zero,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(Get.context!)
                              .dialogTheme
                              .backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        padding: Dimens.edgeInsets12,
                        child: NxIconButton(
                          icon: Icons.send,
                          iconColor: ColorValues.primaryColor,
                          iconSize: Dimens.twentyFour,
                          onTap: () {
                            Get.back();
                            logic.sendMessage();
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
