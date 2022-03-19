import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/auth/controllers/auth_controller.dart';
import 'package:social_media_app/routes/route_management.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder<AuthController>(
                builder: (logic) => logic.isLoading
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : Column(
                        children: [
                          Text(
                            StringValues.hello +
                                ' ' +
                                logic.userModel.user!.fname,
                            style: AppStyles.style24Bold,
                          ),
                          ElevatedButton(
                            onPressed: () => logic.logout(),
                            child: const Text(StringValues.logout),
                          ),
                        ],
                      ),
              ),
              Dimens.boxHeight16,
              ElevatedButton(
                onPressed: () {
                  RouteManagement.goToSettingsView();
                },
                child: const Text(StringValues.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
