import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_radio_tile.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NxAppBar(
                  title: StringValues.gender,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight8,
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() => GetBuilder<GenderController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsets0_16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NxRadioTile(
                    padding: Dimens.edgeInsets16_0,
                    onTap: () => logic.setGender = StringValues.male,
                    onChanged: (value) {
                      logic.setGender = value.toString();
                    },
                    title: StringValues.male,
                    value: StringValues.male,
                    groupValue: logic.gender,
                  ),
                  NxRadioTile(
                    padding: Dimens.edgeInsets16_0,
                    onTap: () => logic.setGender = StringValues.female,
                    onChanged: (value) {
                      logic.setGender = value.toString();
                    },
                    title: StringValues.female,
                    value: StringValues.female,
                    groupValue: logic.gender,
                  ),
                  NxRadioTile(
                    padding: Dimens.edgeInsets16_0,
                    onTap: () => logic.setGender = StringValues.others,
                    onChanged: (value) {
                      logic.setGender = value.toString();
                    },
                    title: StringValues.others,
                    value: StringValues.others,
                    groupValue: logic.gender,
                  ),
                  Dimens.boxHeight40,
                  NxFilledButton(
                    onTap: logic.updateGender,
                    label: StringValues.save.toUpperCase(),
                  ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          ),
        ),
      );
}
