import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/common/asset_image.dart';
import 'package:social_media_app/common/loading_indicator.dart';
import 'package:social_media_app/common/primary_outlined_btn.dart';
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
            builder: (logic) {
              if (logic.isLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: NxLoadingIndicator(),
                  ),
                );
              }
              if (logic.postData!.posts == null ||
                  logic.postData!.posts!.isEmpty) {
                return SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        StringValues.noPosts,
                        style: AppStyles.style20Normal.copyWith(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Dimens.boxHeight8,
                      Text(
                        StringValues.followUserLine,
                        style: AppStyles.style16Normal.copyWith(
                          color: Theme.of(context).textTheme.subtitle1!.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Dimens.boxHeight16,
                      NxOutlinedButton(
                        width: Dimens.hundred * 2.0,
                        padding: Dimens.edgeInsets8,
                        label: StringValues.refresh,
                        onTap: () => logic.fetchAllPosts(),
                      )
                    ],
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) => logic.postData!.posts != null
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
              );
            },
          )
        ],
      ),
    );
  }
}
