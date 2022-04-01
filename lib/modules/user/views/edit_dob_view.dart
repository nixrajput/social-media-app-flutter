import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/user/controllers/edit_dob_controller.dart';

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
                  Dimens.boxHeight20,
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     hintText: StringValues.dob,
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   maxLines: 1,
                  //   keyboardType: TextInputType.datetime,
                  //   style: AppStyles.style16Normal,
                  //   controller: logic.dobTextController,
                  //   onEditingComplete: logic.focusNode.unfocus,
                  // ),
                  SizedBox(
                    height: Dimens.hundred * 2,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: logic.dobTextController.text.isNotEmpty
                          ? DateTime.parse(logic.dobTextController.text)
                          : DateTime.now(),
                      maximumDate: DateTime.now(),
                      minimumDate: DateTime(1900),
                      backgroundColor:
                          Theme.of(Get.context!).scaffoldBackgroundColor,
                      onDateTimeChanged: (dt) {
                        printInfo(info: dt.toString());
                        logic.dobTextController.text = dt.toLocal().toString();
                      },
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
