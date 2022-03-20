import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/cached_network_image.dart';
import 'package:social_media_app/common/sliver_app_bar.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/controllers/home_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (logic) => SafeArea(
        child: CustomScrollView(
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) => Padding(
                  padding: Dimens.edgeInsets16,
                  child: Column(
                    children: const [
                      NxNetworkImage(
                          imageUrl:
                              'https://nixrajput.nixlab.co.in/_next/static/media/about01.db694167.png'),
                      Divider(),
                    ],
                  ),
                ),
                childCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
