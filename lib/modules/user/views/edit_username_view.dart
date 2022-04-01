import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/user/controllers/edit_username_controller.dart';

class EditUsernameView extends StatelessWidget {
  const EditUsernameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: GetBuilder<UsernameController>(
              builder: (logic) => Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NxAppBar(
                        title: StringValues.username,
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
                      onTap: logic.updateUsername,
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

  Widget _buildBody(UsernameController logic) => Expanded(
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
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: StringValues.username,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 1,
                    initialValue: logic.username,
                    keyboardType: TextInputType.text,
                    style: AppStyles.style16Normal,
                    onChanged: (value) {
                      logic.setUsername = value;
                    },
                    onEditingComplete: logic.focusNode.unfocus,
                  ),
                  Dimens.boxHeight8,
                  if (logic.isUnameAvailable == StringValues.success)
                    const Text(
                      StringValues.usernameAvailable,
                      style: TextStyle(
                        color: ColorValues.successColor,
                      ),
                    ),
                  if (logic.isUnameAvailable == StringValues.error)
                    const Text(
                      StringValues.usernameNotAvailable,
                      style: TextStyle(
                        color: ColorValues.errorColor,
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
