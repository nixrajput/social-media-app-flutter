import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
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
              const Text(StringValues.hello),
              ElevatedButton(
                onPressed: () {
                  RouteManagement.goToSettingsView();
                },
                child: const Text(StringValues.settings),
              ),
              Dimens.boxHeight16,
              ElevatedButton(
                onPressed: () {
                  RouteManagement.goToLoginView();
                },
                child: const Text(StringValues.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
