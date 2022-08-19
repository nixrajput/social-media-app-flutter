import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';
import 'package:social_media_app/modules/auth/controllers/login_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

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
                  title: StringValues.login,
                  padding: Dimens.edgeInsets8_16,
                ),
                _buildLoginFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginFields() => GetBuilder<LoginController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsets0_16,
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Dimens.boxHeight32,
                    Text(
                      StringValues.loginWelcome,
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
                            borderRadius: BorderRadius.circular(Dimens.eight),
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
                        obscureText: logic.showPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.eight),
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
                        style: AppStyles.style16Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                        controller: logic.passwordTextController,
                        onEditingComplete: logic.focusNode.unfocus,
                      ),
                    ),
                    Dimens.boxHeight32,
                    const NxTextButton(
                      label: StringValues.forgotPassword,
                      onTap: RouteManagement.goToForgotPasswordView,
                    ),
                    Dimens.boxHeight32,
                    NxFilledButton(
                      onTap: () => logic.login(),
                      label: StringValues.login.toUpperCase(),
                    ),
                    Dimens.boxHeight48,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringValues.doNotHaveAccount,
                          style: AppStyles.style14Normal,
                        ),
                        Dimens.boxWidth4,
                        NxTextButton(
                          label: StringValues.register,
                          onTap: () {
                            RouteManagement.goToBack();
                            RouteManagement.goToRegisterView();
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
}
