import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Contains the dimensions and padding used
/// all over the application.
abstract class Dimens {
  static double screenHeight = Get.mediaQuery.size.height;
  static double screenWidth = Get.mediaQuery.size.width;

  static double sixTeen = 16.r;
  static double nineteen = 19.r;
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
  static double pointFive = 0.5.r;
  static double twentySix = 26.r;
  static double sixtyFour = 64.r;
  static double twenty = 20.r;
  static double ten = 10.r;
  static double five = 5.r;
  static double fifteen = 15.r;
  static double four = 4.r;
  static double two = 2.r;
  static double fourteen = 14.r;
  static double twelve = 12.r;
  static double thirtyTwo = 32.r;
  static double thirtyFive = 35.r;
  static double seventy = 70.r;
  static double fourty = 40.r;
  static double thirtyFour = 34.r;
  static double seven = 7.r;
  static double ninetyEight = 98.r;
  static double ninetyFive = 95.r;
  static double fiftyFive = 55.r;
  static double fiftyFour = 54.r;
  static double hundred = 100.r;
  static double oneHundredFifty = 150.r;
  static double oneHundredTwenty = 120.r;
  static double seventyEight = 78.r;

  /// Get the height with the percent value of the screen height.
  static double percentHeight(double percentValue) => percentValue.sh;

  /// Get the width with the percent value of the screen width.
  static double percentWidth(double percentValue) => percentValue.sw;

  static EdgeInsets edgeInsets24_0_24_10 = EdgeInsets.fromLTRB(
    twentyFour,
    zero,
    twentyFour,
    ten,
  );
  static EdgeInsets edgeInsets15_10_15_10 = EdgeInsets.fromLTRB(
    fifteen,
    ten,
    fifteen,
    ten,
  );
  static EdgeInsets edgeInsets20_0_0_0 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets0_15_0_15 = EdgeInsets.fromLTRB(
    zero,
    fifteen,
    zero,
    fifteen,
  );
  static EdgeInsets edgeInsets20_14P_0_0 = EdgeInsets.fromLTRB(
    twenty,
    percentHeight(0.14),
    zero,
    zero,
  );
  static EdgeInsets edgeInsets20_10P_20_20 = EdgeInsets.fromLTRB(
    twenty,
    percentHeight(0.10),
    twenty,
    twenty,
  );
  static EdgeInsets edgeInsets20_10_20_10 = EdgeInsets.fromLTRB(
    twenty,
    ten,
    twenty,
    ten,
  );
  static EdgeInsets edgeInsets0_80_0_100 = EdgeInsets.fromLTRB(
    zero,
    eighty,
    zero,
    hundred,
  );
  static EdgeInsets edgeInsets50_10_50_10 = EdgeInsets.fromLTRB(
    fifty,
    ten,
    fifty,
    ten,
  );
  static EdgeInsets edgeInsets25_20_25_20 = EdgeInsets.fromLTRB(
    twentyFive,
    twenty,
    twentyFive,
    twenty,
  );
  static EdgeInsets edgeInsets15_0_15_20 = EdgeInsets.fromLTRB(
    fifteen,
    zero,
    fifteen,
    twenty,
  );
  static EdgeInsets edgeInsets0_0_10_0 = EdgeInsets.fromLTRB(
    zero,
    zero,
    ten,
    zero,
  );
  static EdgeInsets edgeInsets24_0_24_0 = EdgeInsets.fromLTRB(
    twentyFour,
    zero,
    twentyFour,
    zero,
  );
  static EdgeInsets edgeInsets0_10_0_0 = EdgeInsets.fromLTRB(
    zero,
    ten,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets0_0_0_15 = EdgeInsets.fromLTRB(
    zero,
    zero,
    zero,
    fifteen,
  );
  static EdgeInsets edgeInsets20_0_20_0 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    twenty,
    zero,
  );
  static EdgeInsets edgeInsets20_0_5_0 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    five,
    zero,
  );
  static EdgeInsets edgeInsets20_0_20_20 = EdgeInsets.fromLTRB(
    twenty,
    zero,
    twenty,
    twenty,
  );
  static EdgeInsets edgeInsets0_5_0_0 = EdgeInsets.fromLTRB(
    zero,
    five,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets10_5_10_5 = EdgeInsets.fromLTRB(
    ten,
    five,
    ten,
    five,
  );
  static EdgeInsets edgeInsets20_120_20_50 = EdgeInsets.fromLTRB(
    twenty,
    oneHundredTwenty,
    twenty,
    fifty,
  );
  static EdgeInsets edgeInsets24_0_40_34 = EdgeInsets.fromLTRB(
    fourty,
    zero,
    fourty,
    thirtyFour,
  );
  static EdgeInsets edgeInsets0_30_0_50 = EdgeInsets.fromLTRB(
    zero,
    thirty,
    zero,
    fifty,
  );
  static EdgeInsets edgeInsets0_15_0_50 = EdgeInsets.fromLTRB(
    zero,
    fifteen,
    zero,
    fifty,
  );
  static EdgeInsets edgeInsets30_0_30_30 = EdgeInsets.fromLTRB(
    thirty,
    zero,
    thirty,
    thirty,
  );
  static EdgeInsets edgeInsets40_0_40_0 = EdgeInsets.fromLTRB(
    fourty,
    zero,
    fourty,
    zero,
  );
  static EdgeInsets edgeInsets50_0_50_0 = EdgeInsets.fromLTRB(
    fifty,
    zero,
    fifty,
    zero,
  );
  static EdgeInsets edgeInsets0_54_0_0 = EdgeInsets.fromLTRB(
    zero,
    fiftyFour,
    zero,
    zero,
  );
  static EdgeInsets edgeInsets50_30_50_0 = EdgeInsets.fromLTRB(
    fifty,
    thirty,
    fifty,
    zero,
  );
  static EdgeInsets edgeInsets10_0_10_5 = EdgeInsets.fromLTRB(
    ten,
    zero,
    ten,
    five,
  );
  static EdgeInsets edgeInsets10_0_10_0 = EdgeInsets.fromLTRB(
    ten,
    zero,
    ten,
    zero,
  );
  static EdgeInsets edgeInsets0_10P_0_10 = EdgeInsets.fromLTRB(
    zero,
    percentHeight(0.10),
    zero,
    five,
  );
  static EdgeInsets edgeInsets0_0_0_20 = EdgeInsets.fromLTRB(
    zero,
    zero,
    zero,
    twenty,
  );
  static EdgeInsets edgeInsets0_0_0_80 = EdgeInsets.fromLTRB(
    zero,
    zero,
    zero,
    eighty,
  );
  static EdgeInsets edgeInsets0_12P_0_80 = EdgeInsets.fromLTRB(
    zero,
    percentHeight(0.12),
    zero,
    eighty,
  );
  static EdgeInsets edgeInsets0_14P_0_80 = EdgeInsets.fromLTRB(
    zero,
    percentHeight(0.14),
    zero,
    eighty,
  );
  static EdgeInsets edgeInsets15 = EdgeInsets.all(
    fifteen,
  );
  static EdgeInsets edgeInsets2 = EdgeInsets.all(
    two,
  );
  static EdgeInsets edgeInsets5 = EdgeInsets.all(
    five,
  );
  static EdgeInsets edgeInsetsTopTwelvePercent = EdgeInsets.only(
    top: percentHeight(0.12),
  );
  static EdgeInsets edgeInsets10 = EdgeInsets.all(
    ten,
  );
  static EdgeInsets edgeInsets40 = EdgeInsets.all(
    fourty,
  );
  static EdgeInsets edgeInsets16 = EdgeInsets.all(
    sixTeen,
  );
  static EdgeInsets edgeInsets20 = EdgeInsets.all(
    twenty,
  );

  static SizedBox boxHeight10 = SizedBox(
    height: ten,
  );

  static SizedBox boxHeight64 = SizedBox(
    height: sixtyFour,
  );
  static SizedBox boxHeight5 = SizedBox(
    height: five,
  );
  static SizedBox boxHeight1 = SizedBox(
    height: one,
  );
  static SizedBox boxHeight3 = SizedBox(
    height: three,
  );
  static SizedBox boxHeight32 = SizedBox(
    height: thirtyTwo,
  );
  static SizedBox boxHeight35 = SizedBox(
    height: thirtyFive,
  );
  static SizedBox boxHeight16 = SizedBox(
    height: sixTeen,
  );
  static SizedBox boxHeight30 = SizedBox(
    height: thirty,
  );
  static SizedBox boxHeight40 = SizedBox(
    height: fourty,
  );
  static SizedBox boxWidth12 = SizedBox(
    width: twelve,
  );
  static SizedBox boxWidth10 = SizedBox(
    width: ten,
  );
  static SizedBox boxWidth20 = SizedBox(
    width: twenty,
  );
  static SizedBox boxWidth40 = SizedBox(
    width: fourty,
  );

  static SizedBox boxWidth60 = SizedBox(
    width: sixty,
  );
  static SizedBox boxHeight20 = SizedBox(
    height: twenty,
  );
  static SizedBox boxHeight25 = SizedBox(
    height: twentyFive,
  );
  static SizedBox boxHeight15 = SizedBox(
    height: fifteen,
  );
  static SizedBox boxWidth15 = SizedBox(
    width: fifteen,
  );
  static SizedBox boxHeight26 = SizedBox(
    height: twentySix,
  );
  static SizedBox box0 = SizedBox(
    height: zero,
    width: zero,
  );
}
