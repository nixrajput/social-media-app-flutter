import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/custom_app_bar.dart';
import 'package:social_media_app/common/custom_list_tile.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
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
          physics: const BouncingScrollPhysics(),
          child: NxElevatedCard(
            child: Padding(
              padding: Dimens.edgeInsets8,
              child: GetBuilder<AuthController>(
                builder: (logic) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Dimens.boxHeight8,
                    _buildProfileImage(logic),
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
                        '${logic.userData.user!.fname} ${logic.userData.user!.lname}',
                        style: AppStyles.style16Normal,
                      ),
                      onTap: RouteManagement.goToEditNameView,
                    ),
                    Dimens.boxHeight16,
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
                        logic.userData.user!.uname,
                        style: AppStyles.style16Normal,
                      ),
                      onTap: RouteManagement.goToEditUsernameView,
                    ),
                    Dimens.boxHeight16,
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
                        logic.userData.user!.email,
                        style: AppStyles.style16Normal,
                      ),
                    ),
                    Dimens.boxHeight16,
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
                        logic.userData.user!.about ?? '',
                        style: AppStyles.style16Normal,
                      ),
                      onTap: RouteManagement.goToEditAboutView,
                    ),
                    Dimens.boxHeight16,
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
                        logic.userData.user!.dob ?? '',
                        style: AppStyles.style16Normal,
                      ),
                    ),
                    Dimens.boxHeight16,
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
                        logic.userData.user!.gender ?? '',
                        style: AppStyles.style16Normal,
                      ),
                    ),
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildProfileImage(AuthController logic) {
    if (logic.userData.user != null && logic.userData.user!.avatar != null) {
      return NxCircleNetworkImage(
        imageUrl: logic.userData.user!.avatar!.url,
        radius: Dimens.sixtyFour,
      );
    }
    return NxCircleAssetImage(
      imgAsset: AssetValues.avatar,
      radius: Dimens.sixtyFour,
    );
  }
}
