import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/settings/controllers/change_phone_controller.dart';

class ChangePhoneView extends StatelessWidget {
  const ChangePhoneView({Key? key}) : super(key: key);

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
                  title: StringValues.changePhone,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight16,
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() => GetBuilder<ChangePhoneController>(
        builder: (logic) {
          return Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: Dimens.edgeInsets0_16,
                child: FocusScope(
                  node: logic.focusNode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (logic.profile.profileDetails.user!.phone != null)
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Your current phone number is ',
                              ),
                              TextSpan(
                                text: logic.profile.profileDetails.user!.phone,
                                style: AppStyles.style14Bold,
                              ),
                              const TextSpan(
                                  text:
                                      '. Enter the new phone number you want to change with it.'),
                            ],
                            style: AppStyles.style14Normal.copyWith(
                              color: Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1!
                                  .color,
                            ),
                          ),
                        )
                      else
                        RichText(
                          text: TextSpan(
                            children: const [
                              TextSpan(
                                  text:
                                      'Enter a phone number you want to add.'),
                            ],
                            style: AppStyles.style14Normal.copyWith(
                              color: Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1!
                                  .color,
                            ),
                          ),
                        ),
                      Dimens.boxHeight32,
                      Row(
                        children: [
                          InkWell(
                            onTap: logic.showCountryCodePicker,
                            child: Container(
                              height: Dimens.fiftySix,
                              padding: Dimens.edgeInsets0_8,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(Get.context!).dividerColor,
                                ),
                                borderRadius:
                                    BorderRadius.circular(Dimens.eight),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: Dimens.twentyFour,
                                    height: Dimens.twentyFour,
                                    child: logic.code.flagImage,
                                  ),
                                  Dimens.boxWidth8,
                                  Text(
                                    logic.code.dialCode,
                                    style: AppStyles.style16Bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Dimens.boxWidth16,
                          Expanded(
                            child: Container(
                              height: Dimens.fiftySix,
                              constraints:
                                  BoxConstraints(maxWidth: Dimens.screenWidth),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.eight),
                                  ),
                                  hintStyle: AppStyles.style14Normal.copyWith(
                                    color: ColorValues.grayColor,
                                  ),
                                  hintText: StringValues.phoneNo,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(12),
                                ],
                                enabled: logic.otpSent ? false : true,
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                style: AppStyles.style14Normal.copyWith(
                                  color: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                                onChanged: (value) =>
                                    logic.onChangePhone(value),
                                onEditingComplete: () =>
                                    logic.focusNode.unfocus(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Dimens.boxHeight16,
                      if (logic.otpSent) Dimens.boxHeight16,
                      if (logic.otpSent)
                        Container(
                          height: Dimens.fiftySix,
                          constraints:
                              BoxConstraints(maxWidth: Dimens.screenWidth),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimens.eight),
                              ),
                              hintStyle: AppStyles.style14Normal.copyWith(
                                color: ColorValues.grayColor,
                              ),
                              hintText: StringValues.otp,
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            style: AppStyles.style14Normal.copyWith(
                              color: Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1!
                                  .color,
                            ),
                            onChanged: (value) => logic.onChangeOtp(value),
                            onEditingComplete: () => logic.focusNode.unfocus(),
                          ),
                        ),
                      Dimens.boxHeight40,
                      NxFilledButton(
                        onTap: logic.otpSent
                            ? logic.addChangePhone
                            : logic.sendAddChangePhoneOtp,
                        label: logic.otpSent
                            ? StringValues.save.toUpperCase()
                            : StringValues.next.toUpperCase(),
                      ),
                      Dimens.boxHeight16,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
