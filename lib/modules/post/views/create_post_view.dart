import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/common/primary_text_field.dart';
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
                    NxTextField(
                      label: StringValues.caption,
                      editingController: logic.captionTextController,
                      icon: CupertinoIcons.captions_bubble,
                      inputType: TextInputType.multiline,
                      maxLines: 3,
                    ),
                    Dimens.boxHeight40,
                    NxFilledButton(
                      onTap: logic.createNewPost,
                      label: StringValues.save,
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
