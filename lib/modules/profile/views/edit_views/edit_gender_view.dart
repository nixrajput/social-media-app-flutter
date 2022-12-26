import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
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
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) => GetBuilder<EditGenderController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Padding(
              padding: Dimens.edgeInsetsHorizDefault,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Dimens.boxHeight8,

                  /// Male
                  NxRadioTile(
                    padding: Dimens.edgeInsets12,
                    bgColor: Theme.of(context).bottomAppBarColor,
                    borderRadius: BorderRadius.circular(Dimens.four),
                    onTap: () => logic.setGender = StringValues.male,
                    onChanged: (value) {
                      logic.setGender = value.toString();
                    },
                    title: Text(
                      StringValues.male.toTitleCase(),
                      style: AppStyles.style14Bold,
                    ),
                    value: StringValues.male,
                    groupValue: logic.gender,
                  ),

                  Dimens.boxHeight8,

                  /// Female
                  NxRadioTile(
                    padding: Dimens.edgeInsets12,
                    bgColor: Theme.of(context).bottomAppBarColor,
                    borderRadius: BorderRadius.circular(Dimens.four),
                    onTap: () => logic.setGender = StringValues.female,
                    onChanged: (value) {
                      logic.setGender = value.toString();
                    },
                    title: Text(
                      StringValues.female.toTitleCase(),
                      style: AppStyles.style14Bold,
                    ),
                    value: StringValues.female,
                    groupValue: logic.gender,
                  ),

                  Dimens.boxHeight8,

                  /// Others
                  NxRadioTile(
                    padding: Dimens.edgeInsets12,
                    bgColor: Theme.of(context).bottomAppBarColor,
                    borderRadius: BorderRadius.circular(Dimens.four),
                    onTap: () => logic.setGender = StringValues.others,
                    onChanged: (value) {
                      logic.setGender = value.toString();
                    },
                    title: Text(
                      StringValues.others.toTitleCase(),
                      style: AppStyles.style14Bold,
                    ),
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
