import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profile_picture_controller.dart';
import 'package:social_media_app/modules/profile/controllers/profile_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class ProfileDetailsView extends StatelessWidget {
  const ProfileDetailsView({Key? key}) : super(key: key);

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
                  title: StringValues.editProfile,
                  padding: Dimens.edgeInsets8_16,
                ),
                Dimens.boxHeight24,
                _buildEditProfileBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditProfileBody() => GetBuilder<ProfileController>(
        builder: (logic) {
          return Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: Dimens.edgeInsets0_16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GetBuilder<EditProfilePictureController>(
                      builder: (con) => GestureDetector(
                        onTap: con.chooseImage,
                        child: Hero(
                          tag: logic.profileData.user!.id,
                          child: AvatarWidget(
                            avatar: logic.profileData.user!.avatar,
                          ),
                        ),
                      ),
                    ),
                    Dimens.boxHeight16,
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
                    NxListTile(
                      leading: const Icon(Icons.work_outline),
                      title: Text(
                        StringValues.profession,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        (logic.profileData.user!.profession == null ||
                                logic.profileData.user!.profession == 'user')
                            ? 'Add your profession'
                            : logic.profileData.user!.profession!,
                        style: AppStyles.style16Normal.copyWith(
                          color: (logic.profileData.user!.profession == null ||
                                  logic.profileData.user!.profession == 'user')
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
                    ),
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
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          );
        },
      );
}
