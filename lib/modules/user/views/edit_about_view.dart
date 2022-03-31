import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/common/primary_text_field.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/user/controllers/edit_about_controller.dart';

class EditAboutView extends StatelessWidget {
  const EditAboutView({Key? key}) : super(key: key);

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
                  title: StringValues.about,
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
              child: GetBuilder<AboutController>(
                builder: (logic) => FocusScope(
                  node: logic.focusNode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NxTextField(
                        label: StringValues.about,
                        editingController: logic.aboutTextController,
                        icon: CupertinoIcons.at,
                        onEditingComplete: logic.focusNode.unfocus,
                        inputType: TextInputType.multiline,
                        maxLines: 4,
                      ),
                      Dimens.boxHeight40,
                      NxFilledButton(
                        onTap: logic.updateAbout,
                        label: StringValues.save,
                      ),
                      Dimens.boxHeight16,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
