import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/primary_text_field.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/modules/auth/controllers/auth_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

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
                const NxAppBar(
                  title: StringValues.editProfile,
                ),
                _buildEditProfileBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditProfileBody() => Expanded(
        child: SingleChildScrollView(
          child: NxElevatedCard(
            child: Padding(
              padding: Dimens.edgeInsets8,
              child: GetBuilder<AuthController>(
                builder: (logic) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NxTextField(
                      label: StringValues.name,
                      initialValue:
                          '${logic.userModel.user!.fname} ${logic.userModel.user!.lname}',
                      icon: CupertinoIcons.person,
                      enabled: false,
                      onTap: RouteManagement.goToEditNameView,
                    ),
                    Dimens.boxHeight8,
                    NxTextField(
                      label: StringValues.username,
                      initialValue: logic.userModel.user!.uname,
                      icon: CupertinoIcons.at,
                      enabled: false,
                      onTap: RouteManagement.goToEditUsernameView,
                    ),
                    Dimens.boxHeight8,
                    NxTextField(
                      label: StringValues.email,
                      initialValue: logic.userModel.user!.email,
                      icon: CupertinoIcons.mail,
                      enabled: false,
                    ),
                    Dimens.boxHeight8,
                    NxTextField(
                      label: StringValues.about,
                      initialValue: logic.userModel.user!.about,
                      icon: CupertinoIcons.doc_text,
                      enabled: false,
                      maxLines: 4,
                      onTap: RouteManagement.goToEditAboutView,
                    ),
                    Dimens.boxHeight8,
                    NxTextField(
                      label: StringValues.birthDate,
                      initialValue: logic.userModel.user!.dob,
                      icon: Icons.cake_outlined,
                      enabled: false,
                      //onTap: RouteManagement.goToEditNameView,
                    ),
                    Dimens.boxHeight8,
                    NxTextField(
                      label: StringValues.gender,
                      initialValue: logic.userModel.user!.gender,
                      icon: Icons.male_outlined,
                      enabled: false,
                      //onTap: RouteManagement.goToEditNameView,
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
