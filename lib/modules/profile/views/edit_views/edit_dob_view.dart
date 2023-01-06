import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/profile/controllers/edit_dob_controller.dart';

class EditDOBView extends StatelessWidget {
  const EditDOBView({Key? key}) : super(key: key);

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
                  title: StringValues.birthDate,
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() => GetBuilder<EditDOBController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsetsHorizDefault,
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Dimens.boxHeight8,
                    GestureDetector(
                      onTap: () => _showDatePicker(logic),
                      child: Container(
                        height: Dimens.fiftySix,
                        constraints:
                            BoxConstraints(maxWidth: Dimens.screenWidth),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: StringValues.dob,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimens.four),
                            ),
                            hintStyle: AppStyles.style14Normal.copyWith(
                              color: ColorValues.grayColor,
                            ),
                          ),
                          maxLines: 1,
                          keyboardType: TextInputType.datetime,
                          style: AppStyles.style16Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                          controller: logic.dobTextController,
                          enabled: false,
                          onEditingComplete: logic.focusNode.unfocus,
                        ),
                      ),
                    ),
                    Dimens.boxHeight40,
                    NxFilledButton(
                      onTap: logic.updateDOB,
                      label: StringValues.save.toUpperCase(),
                      height: Dimens.fiftySix,
                    ),
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  _showDatePicker(EditDOBController logic) {
    DatePicker.showDatePicker(
      Get.context!,
      theme: DatePickerTheme(
        backgroundColor:
            Theme.of(Get.context!).bottomSheetTheme.backgroundColor!,
        itemStyle: TextStyle(
          color: Theme.of(Get.context!).textTheme.bodyText1!.color,
        ),
        cancelStyle: const TextStyle(
          color: ColorValues.errorColor,
        ),
        doneStyle: const TextStyle(
          color: ColorValues.successColor,
        ),
      ),
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime.now(),
      currentTime: logic.dobTextController.text.isNotEmpty
          ? DateTime.parse(logic.dobTextController.text)
          : DateTime.now(),
      onConfirm: (dt) {
        logic.dobTextController.text = dt.toString().substring(0, 10);
      },
    );
  }
}
