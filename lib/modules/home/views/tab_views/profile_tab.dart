import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/apis/services/auth_controller.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/count_widget.dart';
import 'package:social_media_app/common/elevated_card.dart';
import 'package:social_media_app/common/loading_indicator.dart';
import 'package:social_media_app/common/primary_filled_btn.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
import 'package:social_media_app/common/sliver_app_bar.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/routes/route_management.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: Dimens.screenWidth,
        height: Dimens.screenHeight,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            NxSliverAppBar(
              isPinned: true,
              leading: GetBuilder<AuthController>(
                builder: (logic) => Text(
                  logic.userData.user != null
                      ? logic.userData.user!.uname
                      : StringValues.profile,
                  style: AppStyles.style18Bold,
                ),
              ),
              actions: const InkWell(
                onTap: RouteManagement.goToSettingsView,
                child: Icon(CupertinoIcons.gear_solid),
              ),
            ),
            SliverFillRemaining(
              child: _buildProfileBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBody() => GetBuilder<AuthController>(
        builder: (logic) => (logic.isLoading)
            ? const Center(
                child: NxLoadingIndicator(),
              )
            : logic.userData.user == null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(CupertinoIcons.info),
                        Dimens.boxHeight16,
                        Text(
                          StringValues.userNotFoundError,
                          style: AppStyles.style14Bold,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NxElevatedCard(
                          child: Padding(
                            padding: Dimens.edgeInsets8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    _buildProfileImage(logic),
                                    Dimens.boxWidth16,
                                    NxOutlinedButton(
                                      label: StringValues.editProfile,
                                      onTap:
                                          RouteManagement.goToEditProfileView,
                                      width: Dimens.hundred * 1.2,
                                    ),
                                  ],
                                ),
                                Dimens.boxHeight16,
                                _buildUserDetails(logic),
                              ],
                            ),
                          ),
                        ),
                        Dimens.boxHeight40,
                        _buildActionButtons(logic),
                      ],
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

  Widget _buildUserDetails(AuthController logic) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${logic.userData.user!.fname} ${logic.userData.user!.lname}',
            style: AppStyles.style18Bold,
          ),
          Text(
            "@${logic.userData.user!.uname}",
            style: TextStyle(
              color: Theme.of(Get.context!).textTheme.subtitle1!.color,
            ),
          ),
          if (logic.userData.user!.about != null) Dimens.boxHeight8,
          if (logic.userData.user!.about != null)
            Text(
              logic.userData.user!.about!,
              style: AppStyles.style14Normal,
            ),
          Dimens.boxHeight8,
          Text(
            'Joined ${DateFormat.yMMMd().format(logic.userData.user!.createdAt)}',
            style: const TextStyle(color: ColorValues.grayColor),
          ),
          Dimens.boxHeight16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NxCountWidget(
                title: StringValues.followers,
                value: logic.userData.user!.followers.length.toString(),
                onTap: () {
                  if (kDebugMode) {
                    print('followers tapped');
                  }
                },
              ),
              NxCountWidget(
                title: StringValues.following,
                value: logic.userData.user!.following.length.toString(),
                onTap: () {
                  if (kDebugMode) {
                    print('following tapped');
                  }
                },
              ),
            ],
          ),
        ],
      );

  Widget _buildActionButtons(AuthController logic) => Padding(
        padding: Dimens.edgeInsets0_8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NxOutlinedButton(
              label: StringValues.changePassword,
              onTap: RouteManagement.goToChangePasswordView,
              borderRadius: Dimens.eight,
              padding: Dimens.edgeInsets16_8,
            ),
            Dimens.boxHeight16,
            NxFilledButton(
              label: StringValues.logout,
              onTap: logic.logout,
              borderRadius: Dimens.eight,
            ),
          ],
        ),
      );
}
