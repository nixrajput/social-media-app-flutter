import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/file_image.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/helpers/utils.dart';
import 'package:social_media_app/modules/home/views/widgets/video_player_widget.dart';
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

  Widget _buildEditBody() => Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Dimens.boxHeight24,
              GetBuilder<CreatePostController>(
                builder: (logic) {
                  return FlutterCarousel.builder(
                    itemCount: logic.pickedFileList!.length,
                    itemBuilder: (ctx, itemIndex, pageViewIndex) {
                      return Stack(
                        children: [
                          AppUtils.isVideoFile(
                                  logic.pickedFileList![itemIndex].path)
                              ? NxVideoPlayerWidget(
                                  url: logic.pickedFileList![itemIndex].path,
                                )
                              : NxFileImage(
                                  file: logic.pickedFileList![itemIndex],
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
                  );
                },
              ),
              Dimens.boxHeight40,
              Padding(
                padding: Dimens.edgeInsets0_16,
                child: NxFilledButton(
                  onTap: RouteManagement.goToAddCaptionView,
                  label: StringValues.next.toUpperCase(),
                ),
              ),
              Dimens.boxHeight16,
            ],
          ),
        ),
      );
}
