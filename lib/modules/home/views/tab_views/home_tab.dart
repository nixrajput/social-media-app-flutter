import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/loading_indicator.dart';
import 'package:social_media_app/common/sliver_app_bar.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/views/widgets/post_widget.dart';
import 'package:social_media_app/routes/route_management.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          NxSliverAppBar(
            isFloating: true,
            bgColor: Theme.of(context).scaffoldBackgroundColor,
            leading: Row(
              children: [
                NxAssetImage(
                  imgAsset: AssetValues.icon,
                  width: Dimens.twentyFour,
                  height: Dimens.twentyFour,
                ),
                Dimens.boxWidth8,
                Text(
                  StringValues.appName,
                  style: AppStyles.style18Bold,
                )
              ],
            ),
            actions: const InkWell(
              onTap: RouteManagement.goToSettingsView,
              child: Icon(CupertinoIcons.gear_solid),
            ),
          ),
          GetBuilder<PostController>(
            builder: (logic) => logic.isLoading
                ? const SliverFillRemaining(
                    child: Center(
                      child: NxLoadingIndicator(),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, index) => logic.postData?.posts != null
                          ? PostWidget(
                              post: logic.postData!.posts!.elementAt(index),
                            )
                          : const Center(
                              child: Text(StringValues.unknownErrorOccurred),
                            ),
                      childCount: logic.postData?.posts != null
                          ? logic.postData!.posts!.length
                          : 1,
                      addAutomaticKeepAlives: true,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
