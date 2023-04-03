import 'package:flutter/cupertino.dart';

class BottomOvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80.0);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80.0);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
