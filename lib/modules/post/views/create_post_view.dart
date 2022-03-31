import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_options.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_carousel_widget/indicators/circular_wave_slide_indicator.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/file_image.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/common/primary_icon_btn.dart';
import 'package:social_media_app/common/primary_text_field.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
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

  Widget _buildEditBody() => Expanded(
        child: SingleChildScrollView(
          child: NxElevatedCard(
            child: Padding(
              padding: Dimens.edgeInsets8,
              child: GetBuilder<CreatePostController>(
                builder: (logic) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (logic.pickedImageList!.length.isGreaterThan(0))
                      FlutterCarousel.builder(
                        itemCount: logic.pickedImageList!.length,
                        itemBuilder: (ctx, _, i) {
                          return Stack(
                            children: [
                              NxFileImage(file: logic.pickedImageList![i]),
                              Positioned(
                                  top: Dimens.four,
                                  right: Dimens.four,
                                  child: NxIconButton(
                                    bgColor:
                                        ColorValues.blackColor.withAlpha(100),
                                    borderRadius: Dimens.eighty,
                                    padding: Dimens.edgeInsets8,
                                    onTap: () {
                                      logic.removePostImage(i);
                                    },
                                    icon: CupertinoIcons.xmark,
                                  )),
                            ],
                          );
                        },
                        options: CarouselOptions(
                          height: Dimens.screenWidth * 0.9,
                          floatingIndicator: false,
                          viewportFraction: 1.0,
                          slideIndicator: CircularWaveSlideIndicator(),
                        ),
                      ),
                    NxTextField(
                      label: StringValues.addCaption,
                      editingController: logic.captionTextController,
                      icon: CupertinoIcons.captions_bubble,
                      inputType: TextInputType.multiline,
                      maxLines: 3,
                    ),
                    Dimens.boxHeight32,
                    NxFilledButton(
                      onTap: logic.createNewPost,
                      label: StringValues.post,
                    ),
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
