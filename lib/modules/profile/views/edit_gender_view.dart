import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/profile/controllers/edit_gender_controller.dart';

class EditGenderView extends StatelessWidget {
  const EditGenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: GetBuilder<GenderController>(
              builder: (logic) => Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NxAppBar(
                        title: StringValues.gender,
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
                      onTap: logic.updateGender,
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

  Widget _buildBody(GenderController logic) => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: Dimens.edgeInsets8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dimens.boxHeight16,
                RadioListTile(
                  onChanged: (value) {
                    logic.setGender = value.toString();
                  },
                  groupValue: logic.gender,
                  value: StringValues.male,
                  title: Text(
                    StringValues.male,
                    style: AppStyles.style16Bold,
                  ),
                  activeColor: ColorValues.primaryColor,
                  contentPadding: Dimens.edgeInsets0,
                ),
                RadioListTile(
                  onChanged: (value) {
                    logic.setGender = value.toString();
                  },
                  groupValue: logic.gender,
                  value: StringValues.female,
                  title: Text(
                    StringValues.female,
                    style: AppStyles.style16Bold,
                  ),
                  activeColor: ColorValues.primaryColor,
                  contentPadding: Dimens.edgeInsets0,
                ),
                RadioListTile(
                  onChanged: (value) {
                    logic.setGender = value.toString();
                  },
                  groupValue: logic.gender,
                  value: StringValues.others,
                  title: Text(
                    StringValues.others,
                    style: AppStyles.style16Bold,
                  ),
                  activeColor: ColorValues.primaryColor,
                  contentPadding: Dimens.edgeInsets0,
                ),
                Dimens.boxHeight16,
              ],
            ),
          ),
        ),
      );
}
