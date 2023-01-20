import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Contains the dimensions and padding used
/// all over the application.
abstract class Dimens {
  static double screenHeight = Get.size.height;
  static double screenWidth = Get.size.width;

  static double pointOne = 0.1.r;
  static double pointTwo = 0.2.r;
  static double pointThree = 0.3.r;
  static double pointFour = 0.4.r;
  static double pointFive = 0.5.r;
  static double pointSix = 0.6.r;
  static double pointSeven = 0.7.r;
  static double pointEight = 0.8.r;
  static double pointNine = 0.9.r;
  static double sixTeen = 16.r;
  static double nineteen = 19.r;
  static double eleven = 11.r;
  static double three = 3.r;
  static double eight = 8.r;
  static double zero = 0.r;
  static double eighteen = 18.r;
  static double thirtySix = 36.r;
  static double twentyEight = 28.r;
  static double six = 6.r;
  static double sixty = 60.r;
  static double twentyTwo = 22.r;
  static double fifty = 50.r;
  static double one = 1.r;
  static double twentyFour = 24.r;
  static double twentyThree = 23.r;
  static double thirtyNine = 39.r;
  static double twentyFive = 25.r;
  static double thirty = 30.r;
  static double eighty = 80.r;
  static double twentySix = 26.r;
  static double sixtyFour = 64.r;
  static double twenty = 20.r;
  static double ten = 10.r;
  static double five = 5.r;
  static double fifteen = 15.r;
  static double thirteen = 13.r;
  static double four = 4.r;
  static double two = 2.r;
  static double fourteen = 14.r;
  static double twelve = 12.r;
  static double thirtyTwo = 32.r;
  static double thirtyFive = 35.r;
  static double seventy = 70.r;
  static double fourty = 40.r;
  static double fourtyEight = 48.r;
  static double thirtyFour = 34.r;
  static double seven = 7.r;
  static double ninetyEight = 98.r;
  static double ninetyFive = 95.r;
  static double fiftyFive = 55.r;
  static double fiftyFour = 54.r;
  static double fiftySix = 56.r;
  static double hundred = 100.r;
  static double oneHundredFifty = 150.r;
  static double oneHundredTwenty = 120.r;
  static double seventyEight = 78.r;

  /// Get the height with the percent value of the screen height.
  static double percentHeight(double percentValue) => percentValue.sh;

  /// Get the width with the percent value of the screen width.
  static double percentWidth(double percentValue) => percentValue.sw;

  //EdgeInsets

  static EdgeInsets edgeInsetsTopTwelvePercent = EdgeInsets.only(
    top: percentHeight(0.12),
  );

  static EdgeInsets edgeInsets2_0 = EdgeInsets.symmetric(
    vertical: two,
    horizontal: zero,
  );

  static EdgeInsets edgeInsets0_2 = EdgeInsets.symmetric(
    vertical: zero,
    horizontal: two,
  );

  static EdgeInsets edgeInsets4_0 = EdgeInsets.symmetric(
    vertical: four,
    horizontal: zero,
  );

  static EdgeInsets edgeInsets4_8 = EdgeInsets.symmetric(
    vertical: four,
    horizontal: eight,
  );

  static EdgeInsets edgeInsets0_4 = EdgeInsets.symmetric(
    vertical: zero,
    horizontal: four,
  );

  static EdgeInsets edgeInsets6_0 = EdgeInsets.symmetric(
    vertical: six,
    horizontal: zero,
  );

  static EdgeInsets edgeInsets0_6 = EdgeInsets.symmetric(
    vertical: zero,
    horizontal: six,
  );

  static EdgeInsets edgeInsets8_0 = EdgeInsets.symmetric(
    vertical: eight,
    horizontal: zero,
  );

  static EdgeInsets edgeInsets0_8 = EdgeInsets.symmetric(
    vertical: zero,
    horizontal: eight,
  );

  static EdgeInsets edgeInsets12_0 = EdgeInsets.symmetric(
    vertical: twelve,
    horizontal: zero,
  );

  static EdgeInsets edgeInsets0_12 = EdgeInsets.symmetric(
    vertical: zero,
    horizontal: twelve,
  );

  static EdgeInsets edgeInsets16_0 = EdgeInsets.symmetric(
    vertical: sixTeen,
    horizontal: zero,
  );

  static EdgeInsets edgeInsets0_16 = EdgeInsets.symmetric(
    vertical: zero,
    horizontal: sixTeen,
  );

  static EdgeInsets edgeInsets8_16 = EdgeInsets.symmetric(
    vertical: eight,
    horizontal: sixTeen,
  );

  static EdgeInsets edgeInsets6_8 = EdgeInsets.symmetric(
    vertical: six,
    horizontal: eight,
  );

  static EdgeInsets edgeInsets8_6 = EdgeInsets.symmetric(
    vertical: eight,
    horizontal: six,
  );

  static EdgeInsets edgeInsets6_12 = EdgeInsets.symmetric(
    vertical: six,
    horizontal: twelve,
  );

  static EdgeInsets edgeInsets12_6 = EdgeInsets.symmetric(
    vertical: twelve,
    horizontal: six,
  );

  static EdgeInsets edgeInsets8_32 = EdgeInsets.symmetric(
    vertical: eight,
    horizontal: thirtyTwo,
  );

  static EdgeInsets edgeInsets12_16 = EdgeInsets.symmetric(
    vertical: twelve,
    horizontal: sixTeen,
  );

  static EdgeInsets edgeInsets4_16 = EdgeInsets.symmetric(
    vertical: four,
    horizontal: sixTeen,
  );

  static EdgeInsets edgeInsets4_12 = EdgeInsets.symmetric(
    vertical: four,
    horizontal: twelve,
  );

  static EdgeInsets edgeInsets16_8 = EdgeInsets.symmetric(
    vertical: sixTeen,
    horizontal: eight,
  );

  static EdgeInsets edgeInsets12_8 = EdgeInsets.symmetric(
    vertical: twelve,
    horizontal: eight,
  );

  static EdgeInsets edgeInsets8_12 = EdgeInsets.symmetric(
    vertical: eight,
    horizontal: twelve,
  );

  static EdgeInsets edgeInsets16_12 = EdgeInsets.symmetric(
    vertical: sixTeen,
    horizontal: twelve,
  );

  static EdgeInsets edgeInsetsHorizDefault = EdgeInsets.symmetric(
    vertical: zero,
    horizontal: twelve,
  );

  static EdgeInsets edgeInsetsVertDefault = EdgeInsets.symmetric(
    vertical: twelve,
    horizontal: zero,
  );

  static EdgeInsets edgeInsetsDefault = EdgeInsets.symmetric(
    vertical: eight,
    horizontal: twelve,
  );

  static EdgeInsets edgeInsetsRight4 = EdgeInsets.only(right: four);

  static EdgeInsets edgeInsetsRight6 = EdgeInsets.only(right: six);

  static EdgeInsets edgeInsetsRight8 = EdgeInsets.only(right: eight);

  static EdgeInsets edgeInsetsRight12 = EdgeInsets.only(right: twelve);

  static EdgeInsets edgeInsetsRight16 = EdgeInsets.only(right: sixTeen);

  static EdgeInsets edgeInsetsRight20 = EdgeInsets.only(right: twenty);

  static EdgeInsets edgeInsets0 = EdgeInsets.zero;

  static EdgeInsets edgeInsets2 = EdgeInsets.all(two);

  static EdgeInsets edgeInsets4 = EdgeInsets.all(four);

  static EdgeInsets edgeInsets6 = EdgeInsets.all(six);

  static EdgeInsets edgeInsets8 = EdgeInsets.all(eight);

  static EdgeInsets edgeInsets10 = EdgeInsets.all(ten);

  static EdgeInsets edgeInsets12 = EdgeInsets.all(twelve);

  static EdgeInsets edgeInsets16 = EdgeInsets.all(sixTeen);

  static EdgeInsets edgeInsets20 = EdgeInsets.all(twenty);

  static EdgeInsets edgeInsetsOnlyTop2 = EdgeInsets.only(top: two);

  static EdgeInsets edgeInsetsOnlyTop4 = EdgeInsets.only(top: four);

  static EdgeInsets edgeInsetsOnlyTop8 = EdgeInsets.only(top: eight);

  static EdgeInsets edgeInsetsOnlyTop12 = EdgeInsets.only(top: twelve);

  static EdgeInsets edgeInsetsOnlyTop16 = EdgeInsets.only(top: sixTeen);

  static EdgeInsets edgeInsetsOnlyBottom2 = EdgeInsets.only(bottom: two);

  static EdgeInsets edgeInsetsOnlyBottom4 = EdgeInsets.only(bottom: four);

  static EdgeInsets edgeInsetsOnlyBottom8 = EdgeInsets.only(bottom: eight);

  static EdgeInsets edgeInsetsOnlyBottom12 = EdgeInsets.only(bottom: twelve);

  static EdgeInsets edgeInsetsOnlyBottom16 = EdgeInsets.only(bottom: sixTeen);

  static EdgeInsets edgeInsetsOnlyLeft8 = EdgeInsets.only(left: eight);

  static EdgeInsets edgeInsetsOnlyLeft12 = EdgeInsets.only(left: twelve);

  static EdgeInsets edgeInsetsOnlyLeft16 = EdgeInsets.only(left: sixTeen);

  static EdgeInsets edgeInsetsOnlyLeft20 = EdgeInsets.only(left: twenty);

  static EdgeInsets edgeInsetsOnlyLeft24 = EdgeInsets.only(left: twentyFour);

  static EdgeInsets edgeInsetsOnlyLeft32 = EdgeInsets.only(left: thirtyTwo);

  //SizedBoxes

  static SizedBox boxHeight2 = SizedBox(height: two);

  static SizedBox boxHeight4 = SizedBox(height: four);

  static SizedBox boxHeight8 = SizedBox(height: eight);

  static SizedBox boxHeight10 = SizedBox(height: ten);

  static SizedBox boxHeight12 = SizedBox(height: twelve);

  static SizedBox boxHeight16 = SizedBox(height: sixTeen);

  static SizedBox boxHeight20 = SizedBox(height: twenty);

  static SizedBox boxHeight24 = SizedBox(height: twentyFour);

  static SizedBox boxHeight32 = SizedBox(height: thirtyTwo);

  static SizedBox boxHeight40 = SizedBox(height: fourty);

  static SizedBox boxHeight48 = SizedBox(height: fourtyEight);

  static SizedBox boxHeight64 = SizedBox(height: sixtyFour);

  static SizedBox boxWidth2 = SizedBox(width: two);

  static SizedBox boxWidth4 = SizedBox(width: four);

  static SizedBox boxWidth8 = SizedBox(width: eight);

  static SizedBox boxWidth10 = SizedBox(width: ten);

  static SizedBox boxWidth12 = SizedBox(width: twelve);

  static SizedBox boxWidth16 = SizedBox(width: sixTeen);

  static SizedBox boxWidth20 = SizedBox(width: twenty);

  static SizedBox boxWidth24 = SizedBox(width: twentyFour);

  static SizedBox boxWidth32 = SizedBox(width: thirtyTwo);

  static SizedBox boxWidth40 = SizedBox(width: fourty);

  static SizedBox boxWidth60 = SizedBox(width: sixty);

  static SizedBox boxHeight60 = SizedBox(height: sixty);

  static SizedBox boxWidth80 = SizedBox(width: eighty);

  static SizedBox boxHeight80 = SizedBox(height: eighty);

  static SizedBox shrinkedBox = const SizedBox.shrink();

  static SizedBox heightedBox(double height) => SizedBox(height: height);

  static SizedBox widthedBox(double width) => SizedBox(width: width);

  static Divider divider = Divider(
    height: Dimens.zero,
    thickness: Dimens.pointEight,
  );

  static Divider dividerWithHeight = Divider(
    thickness: Dimens.pointEight,
    height: Dimens.one,
  );
}
