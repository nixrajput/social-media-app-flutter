import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/strings.dart';

class NavBarController extends GetxController {
  int currentTab = 0;

  List<BottomNavigationBarItem>? tab = [
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: StringValues.home,
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.at),
      label: StringValues.search,
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.bell),
      label: StringValues.notifications,
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      label: StringValues.profile,
    ),
  ];

  void changeTab(int index) {
    currentTab = index;
    update();
  }
}
