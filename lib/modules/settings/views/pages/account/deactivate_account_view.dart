import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/settings/controllers/deactivate_account_controller.dart';

class DeactivateAccountView extends StatelessWidget {
  const DeactivateAccountView({Key? key}) : super(key: key);

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
                  title: StringValues.deactivateAccount,
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

  Widget _buildBody() => GetBuilder<DeactivateAccountController>(
        builder: (logic) {
          return Expanded(
            child: SingleChildScrollView(
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: Dimens.edgeInsetsHorizDefault,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Dimens.boxHeight8,
                          RichText(
                            text: TextSpan(
                              text: 'Your account will be deactivated.',
                              style: AppStyles.style20Bold.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                          Dimens.boxHeight8,
                          RichText(
                            text: TextSpan(
                              text:
                                  'This will temporarily deactivate your account.'
                                  ' Your account will no longer be viewable on this'
                                  ' platform.',
                              style: AppStyles.style13Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                          Dimens.boxHeight16,
                          RichText(
                            text: TextSpan(
                              text:
                                  'You can restore your account if it was accidentally'
                                  ' or wrongfully deactivated anytime by logging in '
                                  'to your account again.',
                              style: AppStyles.style13Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                          Dimens.boxHeight16,
                          RichText(
                            text: TextSpan(
                              text:
                                  'If you want to use your current @username or email '
                                  'address with a different account, change them '
                                  'before you deactivate this account.',
                              style: AppStyles.style13Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Dimens.boxHeight16,
                    Dimens.dividerWithHeight,
                    Dimens.boxHeight16,
                    Padding(
                      padding: Dimens.edgeInsetsHorizDefault,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                              text:
                                  'Enter your current password and click on the '
                                  'NEXT button to deactivate your account.',
                              style: AppStyles.style13Normal.copyWith(
                                color: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                              ),
                            ),
                          ),
                          Dimens.boxHeight16,
                          Container(
                            height: Dimens.fiftySix,
                            constraints:
                                BoxConstraints(maxWidth: Dimens.screenWidth),
                            child: TextFormField(
                              obscureText: logic.showPassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.four),
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
                                    .bodyText1!
                                    .color,
                              ),
                              controller: logic.passwordTextController,
                              onEditingComplete: logic.focusNode.nextFocus,
                            ),
                          ),
                          Dimens.boxHeight40,
                          NxFilledButton(
                            onTap: logic.deactivateAccount,
                            label: StringValues.next.toUpperCase(),
                          ),
                        ],
                      ),
                    ),
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          );
        },
      );
}
