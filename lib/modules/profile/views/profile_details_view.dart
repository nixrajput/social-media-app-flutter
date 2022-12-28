import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/data.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/image_viewer_widget.dart';
import 'package:social_media_app/global_widgets/unfocus_widget.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/profile/controllers/edit_profile_picture_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class ProfileDetailsView extends StatelessWidget {
  const ProfileDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
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
                    padding: Dimens.edgeInsetsDefault,
                  ),
                  _buildBody(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) => GetBuilder<ProfileController>(
        builder: (logic) {
          return Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Padding(
                padding: Dimens.edgeInsetsHorizDefault,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Dimens.boxHeight8,

                    /// Profile Picture

                    Center(
                      child: GetBuilder<EditProfilePictureController>(
                        builder: (con) => GestureDetector(
                          onTap: () => _showProfilePictureBottomSheet(context),
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

                    Dimens.boxHeight16,

                    /// Name

                    NxListTile(
                      padding: Dimens.edgeInsets12,
                      bgColor: Theme.of(Get.context!).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(Dimens.four),
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

                    Dimens.boxHeight8,

                    /// Username

                    NxListTile(
                      padding: Dimens.edgeInsets12,
                      bgColor: Theme.of(Get.context!).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(Dimens.four),
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

                    Dimens.boxHeight8,

                    /// About

                    NxListTile(
                      padding: Dimens.edgeInsets12,
                      bgColor: Theme.of(Get.context!).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(Dimens.four),
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

                    Dimens.boxHeight8,

                    /// Profession

                    NxListTile(
                      padding: Dimens.edgeInsets12,
                      bgColor: Theme.of(Get.context!).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(Dimens.four),
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

                    Dimens.boxHeight8,

                    /// DOB

                    NxListTile(
                      padding: Dimens.edgeInsets12,
                      bgColor: Theme.of(Get.context!).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(Dimens.four),
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

                    Dimens.boxHeight8,

                    /// Gender

                    NxListTile(
                      padding: Dimens.edgeInsets12,
                      bgColor: Theme.of(Get.context!).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(Dimens.four),
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

                    Dimens.boxHeight8,

                    /// Email

                    NxListTile(
                      padding: Dimens.edgeInsets12,
                      bgColor: Theme.of(Get.context!).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(Dimens.four),
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

                    Dimens.boxHeight8,

                    /// Phone

                    if (logic.profileDetails!.user!.phone != null)
                      NxListTile(
                        padding: Dimens.edgeInsets12,
                        bgColor: Theme.of(Get.context!).bottomAppBarColor,
                        borderRadius: BorderRadius.circular(Dimens.four),
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

                    Dimens.boxHeight8,

                    /// Website

                    NxListTile(
                      padding: Dimens.edgeInsets12,
                      bgColor: Theme.of(Get.context!).bottomAppBarColor,
                      borderRadius: BorderRadius.circular(Dimens.four),
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
                              : Theme.of(Get.context!)
                                  .textTheme
                                  .bodyText1!
                                  .color,
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

  _showProfilePictureBottomSheet(BuildContext context) =>
      AppUtility.showBottomSheet(
        children: [
          /// View Profile Picture
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.image_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.view,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              Get.to(
                () => ImageViewerWidget(
                    url: ProfileController
                        .find.profileDetails!.user!.avatar!.url!),
              );
            },
          ),

          /// Change Profile Picture
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.camera_alt_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.change,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              EditProfilePictureController.find.chooseImage();
            },
          ),

          /// Remove Profile Picture
          NxListTile(
            padding: Dimens.edgeInsets12,
            leading: Icon(
              Icons.delete_outline,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
            title: Text(
              StringValues.remove,
              style: AppStyles.style16Bold,
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              EditProfilePictureController.find.removeProfilePicture();
            },
          ),
        ],
      );
}
