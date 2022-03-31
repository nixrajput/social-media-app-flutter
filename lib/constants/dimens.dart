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
  static double fourtyEight = 48.r;
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

  //EdgeInsets

  static EdgeInsets edgeInsetsTopTwelvePercent = EdgeInsets.only(
    top: percentHeight(0.12),
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

  static EdgeInsets edgeInsets8_0 = EdgeInsets.symmetric(
    vertical: eight,
    horizontal: zero,
  );

  static EdgeInsets edgeInsets0_8 = EdgeInsets.symmetric(
    vertical: zero,
    horizontal: eight,
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

  static EdgeInsets edgeInsets16_8 = EdgeInsets.symmetric(
    vertical: sixTeen,
    horizontal: eight,
  );

  static EdgeInsets edgeInsets0 = EdgeInsets.zero;

  static EdgeInsets edgeInsets4 = EdgeInsets.all(four);

  static EdgeInsets edgeInsets8 = EdgeInsets.all(eight);

  static EdgeInsets edgeInsets10 = EdgeInsets.all(ten);

  static EdgeInsets edgeInsets16 = EdgeInsets.all(sixTeen);

  static EdgeInsets edgeInsets20 = EdgeInsets.all(twenty);

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
}
