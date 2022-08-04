import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/custom_list_tile.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/modules/settings/controllers/account_type_controller.dart';

class PrivacySettingsView extends StatelessWidget {
  const PrivacySettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NxAppBar(
                title: StringValues.privacy,
              ),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsets8,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GetBuilder<ProfileController>(
                builder: (logic) => NxListTile(
                  leading: Icon(
                    CupertinoIcons.lock,
                    color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${StringValues.private.toTitleCase()} ${StringValues.account}',
                        style: AppStyles.style16Bold,
                      ),
                      GetBuilder<AccountTypeController>(
                        init: AccountTypeController(),
                        builder: (con) => Switch(
                          value: logic.profileData.user!.accountType ==
                                  StringValues.private
                              ? true
                              : false,
                          onChanged: (value) {
                            if (value == false) {
                              con.updateAccountType(StringValues.public);
                              return;
                            }
                            con.updateAccountType(StringValues.private);
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: ColorValues.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Dimens.boxHeight16,
              NxListTile(
                leading: Icon(
                  CupertinoIcons.add_circled,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.posts,
                  style: AppStyles.style16Normal,
                ),
              ),
              Dimens.boxHeight20,
              NxListTile(
                leading: Icon(
                  CupertinoIcons.chat_bubble,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.comments,
                  style: AppStyles.style16Normal,
                ),
              ),
              Dimens.boxHeight20,
              NxListTile(
                leading: Icon(
                  CupertinoIcons.memories,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.story,
                  style: AppStyles.style16Normal,
                ),
              ),
              Dimens.boxHeight20,
              NxListTile(
                leading: Icon(
                  CupertinoIcons.at,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  StringValues.mentions,
                  style: AppStyles.style16Normal,
                ),
              ),
              Dimens.boxHeight20,
              NxListTile(
                leading: Icon(
                  Icons.online_prediction,
                  color: Theme.of(Get.context!).textTheme.bodyText1!.color,
                ),
                title: Text(
                  "${StringValues.activity} ${StringValues.status.toTitleCase()}",
                  style: AppStyles.style16Normal,
                ),
              ),
              Dimens.boxHeight20,
            ],
          ),
        ),
      ),
    );
  }
}
