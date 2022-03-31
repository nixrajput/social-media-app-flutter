import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/common/primary_text_field.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/user/controllers/edit_name_controller.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({Key? key}) : super(key: key);

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
                  title: StringValues.name,
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
              child: GetBuilder<NameController>(
                builder: (logic) => FocusScope(
                  node: logic.focusNode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NxTextField(
                        label: StringValues.firstName,
                        editingController: logic.fNameTextController,
                        icon: CupertinoIcons.person,
                        onEditingComplete: logic.focusNode.nextFocus,
                        inputType: TextInputType.name,
                      ),
                      Dimens.boxHeight16,
                      NxTextField(
                        label: StringValues.lastName,
                        editingController: logic.lNameTextController,
                        icon: CupertinoIcons.person,
                        onEditingComplete: logic.focusNode.unfocus,
                        inputType: TextInputType.name,
                      ),
                      Dimens.boxHeight40,
                      NxFilledButton(
                        onTap: logic.updateName,
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
