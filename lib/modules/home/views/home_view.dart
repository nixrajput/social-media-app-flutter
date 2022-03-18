import 'package:flutter/material.dart';
import 'package:social_media_app/common/cached_network_image.dart';
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
              const NxNetworkImage(
                imageUrl:
                    'https://nixrajput.nixlab.co.in/_next/static/media/profile.ec2dbb8c.png',
              ),
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
