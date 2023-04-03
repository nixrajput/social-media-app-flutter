import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/app_filled_btn.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/settings/controllers/change_email_controller.dart';

class ChangeEmailView extends StatelessWidget {
  const ChangeEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
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
                  title: StringValues.changeEmail,
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

  Widget _buildBody() => GetBuilder<ChangeEmailController>(
        builder: (logic) {
          return Expanded(
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
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${StringValues.current} ${StringValues.email.toLowerCase()} : ',
                            ),
                            TextSpan(
                              text: logic.profile.profileDetails!.user!.email,
                              style: AppStyles.style16Bold,
                            ),
                          ],
                          style: AppStyles.style16Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color,
                          ),
                        ),
                      ),
                      Dimens.boxHeight32,
                      Text(
                        StringValues.yourCurrentEmailDesc,
                        style: AppStyles.style13Normal,
                      ),
                      Dimens.boxHeight12,
                      Container(
                        height: Dimens.fiftySix,
                        constraints:
                            BoxConstraints(maxWidth: Dimens.screenWidth),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimens.four),
                            ),
                            hintStyle: AppStyles.style14Normal.copyWith(
                              color: ColorValues.grayColor,
                            ),
                            hintText: StringValues.email,
                          ),
                          enabled: logic.otpSent ? false : true,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          style: AppStyles.style14Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color,
                          ),
                          controller: logic.emailTextController,
                        ),
                      ),
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
                                    BorderRadius.circular(Dimens.four),
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
                                  .bodyLarge!
                                  .color,
                            ),
                            controller: logic.otpTextController,
                            onEditingComplete: logic.focusNode.nextFocus,
                          ),
                        ),
                      Dimens.boxHeight40,
                      NxFilledButton(
                        onTap: logic.otpSent
                            ? logic.changeEmail
                            : logic.sendChangeEmailOtp,
                        label: logic.otpSent
                            ? StringValues.save.toUpperCase()
                            : StringValues.next.toUpperCase(),
                        height: Dimens.fiftySix,
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
