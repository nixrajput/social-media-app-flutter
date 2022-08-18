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
            child: GetBuilder<DOBController>(
              builder: (logic) => Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NxAppBar(
                        title: StringValues.birthDate,
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
                      onTap: logic.updateDOB,
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

  Widget _buildBody(DOBController logic) => Expanded(
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
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(
                        Get.context!,
                        theme: DatePickerTheme(
                          backgroundColor: Theme.of(Get.context!)
                              .bottomSheetTheme
                              .backgroundColor!,
                          itemStyle: TextStyle(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
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
                          logic.dobTextController.text =
                              dt.toString().substring(0, 10);
                        },
                      );
                    },
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: StringValues.dob,
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          color: ColorValues.grayColor,
                        ),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.datetime,
                      style: AppStyles.style16Normal.copyWith(
                        color:
                            Theme.of(Get.context!).textTheme.bodyText1!.color,
                      ),
                      controller: logic.dobTextController,
                      enabled: false,
                      onEditingComplete: logic.focusNode.unfocus,
                    ),
                  ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          ),
        ),
      );
}
