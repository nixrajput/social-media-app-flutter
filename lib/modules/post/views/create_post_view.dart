import 'package:flutter/cupertino.dart';
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
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/views/widgets/video_player_widget.dart';
import 'package:social_media_app/modules/post/controllers/create_post_controller.dart';

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
            child: GetBuilder<CreatePostController>(
              builder: (logic) {
                return Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const NxAppBar(
                          title: StringValues.createNewPost,
                        ),
                        _buildEditBody(logic),
                      ],
                    ),
                    Positioned(
                      bottom: Dimens.zero,
                      left: Dimens.zero,
                      right: Dimens.zero,
                      child: NxFilledButton(
                        borderRadius: Dimens.zero,
                        onTap: logic.createNewPost,
                        label: StringValues.post,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditBody(CreatePostController logic) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dimens.boxHeight8,
              if (logic.pickedImageList!.length.isGreaterThan(0))
                FlutterCarousel.builder(
                  itemCount: logic.pickedImageList!.length,
                  itemBuilder: (ctx, itemIndex, pageViewIndex) {
                    return Stack(
                      children: [
                        AppUtils.isVideoFile(
                                logic.pickedImageList![itemIndex].path)
                            ? NxVideoPlayerWidget(
                                url: logic.pickedImageList![itemIndex].path,
                              )
                            : NxFileImage(
                                file: logic.pickedImageList![itemIndex],
                              ),
                        Positioned(
                          top: Dimens.four,
                          right: Dimens.four,
                          child: NxIconButton(
                            bgColor: ColorValues.blackColor.withAlpha(200),
                            borderRadius: Dimens.eighty,
                            padding: Dimens.edgeInsets8,
                            onTap: () {
                              logic.removePostImage(itemIndex);
                            },
                            icon: CupertinoIcons.xmark,
                            iconColor: ColorValues.errorColor,
                          ),
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    aspectRatio: 1 / 1,
                    viewportFraction: 1.0,
                    slideIndicator: CircularWaveSlideIndicator(),
                  ),
                ),
              if (logic.pickedImageList!.length.isGreaterThan(0))
                Dimens.boxHeight20,
              if (logic.pickedImageList!.length.isGreaterThan(0))
                Padding(
                  padding: Dimens.edgeInsets0_8,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: StringValues.addCaption,
                    ),
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    style: AppStyles.style16Normal,
                    controller: logic.captionTextController,
                    onEditingComplete: logic.focusNode.unfocus,
                  ),
                ),
              Dimens.boxHeight16,
            ],
          ),
        ),
      );
}
