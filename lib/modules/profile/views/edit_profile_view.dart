import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/custom_list_tile.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profile_picture_controller.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
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

  Widget _buildEditProfileBody() =>
      GetBuilder<ProfileController>(builder: (logic) {
        return Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: NxElevatedCard(
              child: Padding(
                padding: Dimens.edgeInsets8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Dimens.boxHeight8,
                    GetBuilder<EditProfilePictureController>(
                      builder: (con) => GestureDetector(
                        onTap: con.chooseImage,
                        child: _buildProfileImage(logic),
                      ),
                    ),
                    Dimens.boxHeight16,
                    Dimens.dividerWithHeight,
                    NxListTile(
                      leading: const Icon(CupertinoIcons.person),
                      title: Text(
                        StringValues.name,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        '${logic.profileData.user!.fname} ${logic.profileData.user!.lname}',
                        style: AppStyles.style16Normal,
                      ),
                      onTap: RouteManagement.goToEditNameView,
                    ),
                    Dimens.dividerWithHeight,
                    NxListTile(
                      leading: const Icon(CupertinoIcons.at),
                      title: Text(
                        StringValues.username,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileData.user!.uname,
                        style: AppStyles.style16Normal,
                      ),
                      onTap: RouteManagement.goToEditUsernameView,
                    ),
                    Dimens.dividerWithHeight,
                    NxListTile(
                      leading: const Icon(CupertinoIcons.mail),
                      title: Text(
                        StringValues.email,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileData.user!.email,
                        style: AppStyles.style16Normal,
                      ),
                    ),
                    Dimens.dividerWithHeight,
                    NxListTile(
                      leading: const Icon(CupertinoIcons.doc_text),
                      title: Text(
                        StringValues.about,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileData.user!.about ??
                            StringValues.writeSomethingAboutYou,
                        style: AppStyles.style16Normal.copyWith(
                          color: logic.profileData.user!.about == null
                              ? Theme.of(Get.context!)
                                  .textTheme
                                  .subtitle1
                                  ?.color
                              : Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1
                                  ?.color,
                        ),
                        maxLines: 3,
                      ),
                      onTap: RouteManagement.goToEditAboutView,
                    ),
                    Dimens.dividerWithHeight,
                    NxListTile(
                      leading: const Icon(Icons.cake_outlined),
                      title: Text(
                        StringValues.birthDate,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileData.user!.dob ?? StringValues.dobFormat,
                        style: AppStyles.style16Normal.copyWith(
                          color: logic.profileData.user!.dob == null
                              ? Theme.of(Get.context!)
                                  .textTheme
                                  .subtitle1
                                  ?.color
                              : Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1
                                  ?.color,
                        ),
                      ),
                      onTap: RouteManagement.goToEditDOBView,
                    ),
                    Dimens.dividerWithHeight,
                    NxListTile(
                      leading: const Icon(Icons.male_outlined),
                      title: Text(
                        StringValues.gender,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileData.user!.gender ?? StringValues.select,
                        style: AppStyles.style16Normal.copyWith(
                          color: logic.profileData.user!.gender == null
                              ? Theme.of(Get.context!)
                                  .textTheme
                                  .subtitle1
                                  ?.color
                              : Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1
                                  ?.color,
                        ),
                      ),
                      onTap: RouteManagement.goToEditGenderView,
                    ),
                    Dimens.dividerWithHeight,
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          ),
        );
      });

  Widget _buildProfileImage(ProfileController logic) {
    if (logic.profileData.user != null &&
        logic.profileData.user?.avatar != null &&
        logic.profileData.user?.avatar?.url != null) {
      return NxCircleNetworkImage(
        imageUrl: logic.profileData.user!.avatar!.url!,
        radius: Dimens.sixtyFour,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: Dimens.sixtyFour,
    );
  }
}
