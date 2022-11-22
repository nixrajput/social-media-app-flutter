import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/data.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profile_picture_controller.dart';
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
            child: NxRefreshIndicator(
              onRefresh: () =>
                  ProfileController.find.fetchProfileDetails(fetchPost: false),
              showProgress: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NxAppBar(
                    title: StringValues.editProfile,
                    padding: Dimens.edgeInsets8_16,
                  ),
                  Dimens.boxHeight16,
                  _buildEditProfileBody(),
                ],
              ),
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
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Padding(
                padding: Dimens.edgeInsets0_16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GetBuilder<EditProfilePictureController>(
                        builder: (con) => GestureDetector(
                          onTap: con.chooseImage,
                          child: Hero(
                            tag: logic.profileDetails!.user!.id,
                            child: AvatarWidget(
                              avatar: logic.profileDetails!.user!.avatar,
                              size: Dimens.hundred,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Dimens.boxHeight24,

                    /// Name

                    NxListTile(
                      padding: Dimens.edgeInsets12_8,
                      bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimens.eight),
                        topRight: Radius.circular(Dimens.eight),
                      ),
                      leading: const Icon(Icons.person_outline),
                      title: Text(
                        StringValues.name,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        '${logic.profileDetails!.user!.fname} ${logic.profileDetails!.user!.lname}',
                        style: AppStyles.style16Normal,
                      ),
                      onTap: RouteManagement.goToEditNameView,
                    ),

                    Dimens.divider,

                    /// Username

                    NxListTile(
                      padding: Dimens.edgeInsets12_8,
                      bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                      leading: const Icon(Icons.alternate_email_outlined),
                      title: Text(
                        StringValues.username,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileDetails!.user!.uname,
                        style: AppStyles.style16Normal,
                      ),
                      onTap: RouteManagement.goToEditUsernameView,
                    ),

                    Dimens.divider,

                    /// About

                    NxListTile(
                      padding: Dimens.edgeInsets12_8,
                      bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                      leading: const Icon(Icons.note_add_outlined),
                      title: Text(
                        StringValues.about,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileDetails!.user!.about ??
                            StringValues.writeSomethingAboutYou,
                        style: AppStyles.style16Normal.copyWith(
                          color: logic.profileDetails!.user!.about == null
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

                    Dimens.divider,

                    /// Profession

                    NxListTile(
                      padding: Dimens.edgeInsets12_8,
                      bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                      leading: const Icon(Icons.work_outline),
                      title: Text(
                        StringValues.profession,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        (logic.profileDetails!.user!.profession == null ||
                                !StaticData.occupationList.contains(logic
                                    .profileDetails!.user!.profession!
                                    .toLowerCase()))
                            ? 'Add your profession'
                            : logic.profileDetails!.user!.profession!
                                .toTitleCase(),
                        style: AppStyles.style16Normal.copyWith(
                          color:
                              (logic.profileDetails!.user!.profession == null ||
                                      logic.profileDetails!.user!.profession ==
                                          'user')
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
                      onTap: RouteManagement.goToEditProfessionView,
                    ),

                    Dimens.divider,

                    /// DOB

                    NxListTile(
                      padding: Dimens.edgeInsets12_8,
                      bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                      leading: const Icon(Icons.cake_outlined),
                      title: Text(
                        StringValues.birthDate,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileDetails!.user!.dob ??
                            StringValues.dobFormat,
                        style: AppStyles.style16Normal.copyWith(
                          color: logic.profileDetails!.user!.dob == null
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

                    Dimens.divider,

                    /// Gender

                    NxListTile(
                      padding: Dimens.edgeInsets12_8,
                      bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                      leading: const Icon(Icons.male_outlined),
                      title: Text(
                        StringValues.gender,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileDetails!.user!.gender ??
                            StringValues.select,
                        style: AppStyles.style16Normal.copyWith(
                          color: logic.profileDetails!.user!.gender == null
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

                    Dimens.divider,

                    /// Email

                    NxListTile(
                      padding: Dimens.edgeInsets12_8,
                      bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                      leading: const Icon(Icons.email_outlined),
                      title: Text(
                        StringValues.email,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileDetails!.user!.email,
                        style: AppStyles.style16Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyText1!.color,
                        ),
                      ),
                      onTap: () => RouteManagement.goToVerifyPasswordView(
                        RouteManagement.goToChangeEmailSettingsView,
                      ),
                    ),

                    Dimens.divider,

                    /// Phone

                    if (logic.profileDetails!.user!.phone != null)
                      NxListTile(
                        padding: Dimens.edgeInsets12_8,
                        bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                        leading: const Icon(Icons.phone_android),
                        title: Text(
                          StringValues.phone,
                          style: AppStyles.style12Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .subtitle1!
                                .color,
                          ),
                        ),
                        subtitle: Text(
                          '${logic.profileDetails!.user!.countryCode!} ${logic.profileDetails!.user!.phone!}',
                          style: AppStyles.style16Normal.copyWith(
                            color: Theme.of(Get.context!)
                                .textTheme
                                .bodyText1!
                                .color,
                          ),
                        ),
                        onTap: () => RouteManagement.goToVerifyPasswordView(
                          RouteManagement.goToChangePhoneSettingsView,
                        ),
                      ),

                    Dimens.divider,

                    /// Website

                    NxListTile(
                      padding: Dimens.edgeInsets12_8,
                      bgColor: Theme.of(Get.context!).dialogBackgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Dimens.eight),
                        bottomRight: Radius.circular(Dimens.eight),
                      ),
                      leading: const Icon(Icons.link),
                      title: Text(
                        StringValues.website,
                        style: AppStyles.style12Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.subtitle1!.color,
                        ),
                      ),
                      subtitle: Text(
                        logic.profileDetails!.user!.website != null
                            ? Uri.parse(logic.profileDetails!.user!.website!)
                                .host
                            : 'Add website',
                        style: AppStyles.style16Normal.copyWith(
                          color: logic.profileDetails!.user!.website == null
                              ? Theme.of(Get.context!)
                                  .textTheme
                                  .subtitle1
                                  ?.color
                              : ColorValues.primaryColor,
                        ),
                      ),
                      onTap: RouteManagement.goToEditWebsiteView,
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
