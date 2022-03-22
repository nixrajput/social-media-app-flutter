import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/circular_asset_image.dart';
import 'package:social_media_app/common/circular_network_image.dart';
import 'package:social_media_app/common/loading_indicator.dart';
import 'package:social_media_app/common/sliver_app_bar.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/auth/controllers/auth_controller.dart';
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
              isFloating: true,
              bgColor: Theme.of(context).scaffoldBackgroundColor,
              leading: NxAssetImage(
                imgAsset: AssetValues.icon,
                width: Dimens.thirtyTwo,
                height: Dimens.thirtyTwo,
              ),
              title: Text(
                StringValues.appName,
                style: AppStyles.style20Bold,
              ),
              actions: InkWell(
                onTap: () => RouteManagement.goToSettingsView(),
                child: const Icon(CupertinoIcons.gear),
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
            : logic.userModel.user == null
                ? Center(
                    child: Text(
                      StringValues.unknownErrorOccurred,
                      style: AppStyles.style14Bold,
                    ),
                  )
                : Padding(
                    padding: Dimens.edgeInsets8_16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(logic),
                        Dimens.boxHeight8,
                        Text(
                          logic.userModel.user!.fname +
                              ' ' +
                              logic.userModel.user!.lname,
                          style: AppStyles.style18Bold,
                        ),
                        Dimens.boxHeight40,
                        ElevatedButton(
                          onPressed: () => logic.logout(),
                          child: const Text(StringValues.logout),
                        ),
                      ],
                    ),
                  ),
      );

  Widget _buildHeader(logic) => Center(
        child: (logic.userModel.user != null &&
                logic.userModel.user?.avatar == null)
            ? NxCircleAssetImage(
                imgAsset: AssetValues.avatar,
                radius: Dimens.sixtyFour,
              )
            : NxCircleNetworkImage(
                imageUrl: logic.userModel.user?.avatar!.url,
                radius: Dimens.sixtyFour,
              ),
      );
}
