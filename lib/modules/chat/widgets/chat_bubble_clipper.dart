import 'package:flutter/cupertino.dart';
import 'package:social_media_app/constants/enums.dart';

class ChatBubbleClipper extends CustomClipper<Path> {
  final BubbleType? type;
  final double radius;
  final double nipSize;
  final double sizeRatio;

  ChatBubbleClipper(
      {this.type, this.radius = 10, this.nipSize = 8, this.sizeRatio = 2});

  @override
  Path getClip(Size size) {
    var path = Path();

    if (type == BubbleType.sendBubble) {
      path.lineTo(size.width - radius - nipSize, 0);
      path.arcToPoint(Offset(size.width - nipSize, radius),
          radius: Radius.circular(radius));

      path.lineTo(size.width - nipSize, size.height - sizeRatio * nipSize);

      path.lineTo(size.width - nipSize / sizeRatio, size.height - nipSize);

      path.quadraticBezierTo(size.width, size.height, size.width - nipSize,
          size.height - nipSize / sizeRatio);

      path.lineTo(size.width - nipSize, size.height - nipSize / sizeRatio);

      path.lineTo(size.width - sizeRatio * nipSize, size.height - nipSize);

      path.lineTo(radius, size.height - nipSize);

      path.arcToPoint(Offset(0, size.height - radius - nipSize),
          radius: Radius.circular(radius));

      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    } else {
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width, size.height - radius - nipSize);
      path.arcToPoint(Offset(size.width - radius, size.height - nipSize),
          radius: Radius.circular(radius));

      path.lineTo(sizeRatio * nipSize, size.height - nipSize);

      path.lineTo(nipSize, size.height - nipSize / sizeRatio);

      path.quadraticBezierTo(
          0, size.height, nipSize / sizeRatio, size.height - nipSize);

      path.lineTo(nipSize / sizeRatio, size.height - nipSize);

      path.lineTo(nipSize, size.height - sizeRatio * nipSize);

      path.lineTo(nipSize, radius);
      path.arcToPoint(Offset(radius + nipSize, 0),
          radius: Radius.circular(radius));
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
