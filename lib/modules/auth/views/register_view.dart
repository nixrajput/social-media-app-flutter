import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/auth/controllers/register_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

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
                  title: StringValues.register,
                  showBackBtn: true,
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildRegistrationFields(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationFields(BuildContext context) =>
      GetBuilder<RegisterController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsetsHorizDefault,
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Dimens.boxHeight32,
                    Text(
                      StringValues.registerWelcome,
                      style: AppStyles.style32Bold.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Dimens.boxHeight32,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
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
                                hintText: StringValues.firstName,
                              ),
                              keyboardType: TextInputType.name,
                              maxLines: 1,
                              style: AppStyles.style14Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              controller: logic.fNameTextController,
                              onEditingComplete: logic.focusNode.nextFocus,
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
                                      BorderRadius.circular(Dimens.four),
                                ),
                                hintStyle: AppStyles.style14Normal.copyWith(
                                  color: ColorValues.grayColor,
                                ),
                                hintText: StringValues.lastName,
                              ),
                              keyboardType: TextInputType.name,
                              maxLines: 1,
                              style: AppStyles.style14Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                              controller: logic.lNameTextController,
                              onEditingComplete: logic.focusNode.nextFocus,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Dimens.boxHeight16,
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.four),
                          ),
                          hintStyle: AppStyles.style14Normal.copyWith(
                            color: ColorValues.grayColor,
                          ),
                          hintText: StringValues.username,
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        controller: logic.unameTextController,
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
                          hintStyle: AppStyles.style14Normal.copyWith(
                            color: ColorValues.grayColor,
                          ),
                          hintText: StringValues.password,
                          suffixIcon: InkWell(
                            onTap: logic.toggleViewPassword,
                            child: Icon(
                              logic.showPassword
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 1,
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        controller: logic.passwordTextController,
                        onEditingComplete: logic.focusNode.nextFocus,
                      ),
                    ),
                    Dimens.boxHeight16,
                    Container(
                      height: Dimens.fiftySix,
                      constraints: BoxConstraints(maxWidth: Dimens.screenWidth),
                      child: TextFormField(
                        obscureText: logic.showConfirmPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.four),
                          ),
                          hintStyle: AppStyles.style14Normal.copyWith(
                            color: ColorValues.grayColor,
                          ),
                          hintText: StringValues.confirmPassword,
                          suffixIcon: InkWell(
                            onTap: logic.toggleViewConfirmPassword,
                            child: Icon(
                              logic.showConfirmPassword
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 1,
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        controller: logic.confirmPasswordTextController,
                        onEditingComplete: logic.focusNode.unfocus,
                      ),
                    ),
                    Dimens.boxHeight32,
                    NxFilledButton(
                      onTap: () => logic.register(),
                      label: StringValues.register.toUpperCase(),
                    ),
                    Dimens.boxHeight16,
                    _buildAgreeTerms(context),
                    Dimens.boxHeight48,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringValues.alreadyHaveAccount,
                          style: AppStyles.style14Normal,
                        ),
                        Dimens.boxWidth4,
                        NxTextButton(
                          label: StringValues.login,
                          onTap: () {
                            RouteManagement.goToBack();
                            RouteManagement.goToLoginView();
                          },
                        ),
                      ],
                    ),
                    Dimens.boxHeight32,
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  RichText _buildAgreeTerms(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: StringValues.agreeToPrivacyAndTerms1,
          ),
          TextSpan(
            text: StringValues.termsOfUse,
            style: AppStyles.style13Normal.copyWith(
              color: ColorValues.primaryColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  AppUtility.openUrl(Uri.parse(StringValues.termsOfServiceUrl)),
          ),
          const TextSpan(
            text: ', ',
          ),
          TextSpan(
            text: StringValues.privacyPolicy,
            style: AppStyles.style13Normal.copyWith(
              color: ColorValues.primaryColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  AppUtility.openUrl(Uri.parse(StringValues.privacyPolicyUrl)),
          ),
          const TextSpan(
            text: ' ${StringValues.and} ',
          ),
          TextSpan(
            text: StringValues.communityGuidelines,
            style: AppStyles.style13Normal.copyWith(
              color: ColorValues.primaryColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => AppUtility.openUrl(
                  Uri.parse(StringValues.communityGuidelinesUrl)),
          ),
          const TextSpan(
            text: '.',
          ),
        ],
        style: AppStyles.style13Normal.copyWith(
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
      ),
    );
  }
}
