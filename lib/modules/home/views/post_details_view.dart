import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/primary_icon_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/home/controllers/post_details_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_details_widget.dart';

class PostDetailsView extends StatelessWidget {
  const PostDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: Dimens.screenWidth,
                height: Dimens.screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const NxAppBar(
                      title: StringValues.post,
                    ),
                    _buildBody(),
                  ],
                ),
              ),
              Positioned(
                bottom: Dimens.zero,
                left: Dimens.zero,
                right: Dimens.zero,
                child: Container(
                  color: Theme.of(Get.context!).scaffoldBackgroundColor,
                  width: Dimens.screenWidth.w,
                  height: 48.h,
                  child: Row(
                    children: [
                      Dimens.boxWidth4,
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: StringValues.addComment,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Dimens.boxWidth4,
                      NxIconButton(
                        icon: CupertinoIcons.arrow_right,
                        iconColor: ColorValues.whiteColor,
                        height: 48.h,
                        width: 48.w,
                        onTap: () {},
                        bgColor: ColorValues.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: GetBuilder<PostDetailsController>(
        builder: (logic) {
          if (logic.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                PostDetailsWidget(post: logic.postDetails!.post!),
                Dimens.dividerWithHeight,
              ],
            ),
          );
        },
      ),
    );
  }
}
