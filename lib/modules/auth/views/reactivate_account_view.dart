import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/auth/controllers/reactivate_account_controller.dart';

class ReactivateAccountView extends StatelessWidget {
  const ReactivateAccountView({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NxAppBar(
                  title: StringValues.reactivateAccount,
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildLoginFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginFields() => GetBuilder<ReactivateAccountController>(
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
                    Dimens.boxHeight32,
                    Text(
                      'Hi there, Reactivate your account now',
                      style: AppStyles.style32Bold.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Dimens.boxHeight32,
                    Container(
                      height: Dimens.fiftySix,
                      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.four),
                          ),
                          hintText: StringValues.email,
                          hintStyle: AppStyles.style14Normal.copyWith(
                            color: ColorValues.grayColor,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        enabled: logic.otpSent ? false : true,
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        controller: logic.emailTextController,
                        onEditingComplete: logic.focusNode.nextFocus,
                      ),
                    ),
                    Dimens.boxHeight16,
                    Container(
                      height: Dimens.fiftySix,
                      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                      child: TextFormField(
                        obscureText: logic.showPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.four),
                          ),
                          suffixIcon: InkWell(
                            onTap: logic.toggleViewPassword,
                            child: Icon(
                              logic.showPassword
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                            ),
                          ),
                          hintText: StringValues.password,
                          hintStyle: const TextStyle(
                            color: ColorValues.grayColor,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 1,
                        enabled: logic.otpSent ? false : true,
                        style: AppStyles.style16Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        controller: logic.passwordTextController,
                        onEditingComplete: logic.focusNode.unfocus,
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
                              borderRadius: BorderRadius.circular(Dimens.four),
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
                          controller: logic.otpTextController,
                          onEditingComplete: logic.focusNode.nextFocus,
                        ),
                      ),
                    Dimens.boxHeight40,
                    NxFilledButton(
                      onTap: () => logic.otpSent
                          ? logic.reactivateAccount()
                          : logic.sendReactivateAccountOtp(),
                      label: logic.otpSent
                          ? StringValues.reactivateAccount.toUpperCase()
                          : StringValues.sendOtp.toUpperCase(),
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
}
