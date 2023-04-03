import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/app_widgets/app_filled_btn.dart';
import 'package:social_media_app/app_widgets/custom_app_bar.dart';
import 'package:social_media_app/modules/verify_password/verify_password_controller.dart';

class VerifyPasswordView extends StatelessWidget {
  const VerifyPasswordView({Key? key}) : super(key: key);

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
                  title: StringValues.verifyPassword,
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

  Widget _buildBody() => GetBuilder<VerifyPasswordController>(
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
                      Container(
                        height: Dimens.fiftySix,
                        constraints:
                            BoxConstraints(maxWidth: Dimens.screenWidth),
                        child: TextFormField(
                          obscureText: logic.showPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Dimens.four),
                            ),
                            hintStyle: AppStyles.style14Normal.copyWith(
                              color: ColorValues.grayColor,
                            ),
                            hintText: StringValues.currentPassword,
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
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge!
                                .color,
                          ),
                          controller: logic.passwordTextController,
                          onEditingComplete: logic.focusNode.nextFocus,
                        ),
                      ),
                      Dimens.boxHeight40,
                      NxFilledButton(
                        onTap: () => logic.verifyPassword(),
                        label: StringValues.next.toUpperCase(),
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
