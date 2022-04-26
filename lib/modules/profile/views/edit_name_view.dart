import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/profile/controllers/edit_name_controller.dart';

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
            child: GetBuilder<NameController>(
              builder: (logic) => Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NxAppBar(
                        title: StringValues.name,
                      ),
                      _buildBody(logic),
                    ],
                  ),
                  Positioned(
                    bottom: Dimens.zero,
                    left: Dimens.zero,
                    right: Dimens.zero,
                    child: NxFilledButton(
                      borderRadius: Dimens.zero,
                      onTap: logic.updateName,
                      label: StringValues.save,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(NameController logic) => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: Dimens.edgeInsets8,
            child: FocusScope(
              node: logic.focusNode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimens.boxHeight16,
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: StringValues.firstName,
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                        color: ColorValues.grayColor,
                      ),
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    style: AppStyles.style16Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                    controller: logic.fNameTextController,
                    onEditingComplete: logic.focusNode.nextFocus,
                  ),
                  Dimens.boxHeight24,
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: StringValues.lastName,
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(
                        color: ColorValues.grayColor,
                      ),
                    ),
                    maxLines: 1,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    style: AppStyles.style16Normal.copyWith(
                      color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                    ),
                    controller: logic.lNameTextController,
                    onEditingComplete: logic.focusNode.unfocus,
                  ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          ),
        ),
      );
}
