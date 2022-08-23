import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';

class CustomControlsWidget extends StatefulWidget {
  final BetterPlayerController? controller;
  final Function(bool visbility)? onControlsVisibilityChanged;
  final bool? showControls;
  final String timeLeft;
  final String duration;
  final bool isSmallPlayer;

  const CustomControlsWidget({
    Key? key,
    this.controller,
    this.onControlsVisibilityChanged,
    this.showControls = true,
    required this.timeLeft,
    required this.duration,
    required this.isSmallPlayer,
  }) : super(key: key);

  @override
  CustomControlsWidgetState createState() => CustomControlsWidgetState();
}

class CustomControlsWidgetState extends State<CustomControlsWidget> {
  @override
  Widget build(BuildContext context) {
    if (!widget.showControls!) return const SizedBox();
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: widget.isSmallPlayer
            ? MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,
        children: [
          if (!widget.isSmallPlayer)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: Dimens.edgeInsetsOnlyTop4.copyWith(
                  right: Dimens.four,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        backgroundColor:
                            ColorValues.blackColor.withOpacity(0.75),
                        radius: Dimens.sixTeen,
                        child: Icon(
                          widget.controller!.isFullScreen
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                          color: Colors.white,
                          size: Dimens.twenty,
                        ),
                      ),
                      onTap: () => setState(() {
                        if (widget.controller!.isFullScreen) {
                          widget.controller!.exitFullScreen();
                        } else {
                          widget.controller!.enterFullScreen();
                        }
                      }),
                    ),
                    Dimens.boxWidth4,
                    InkWell(
                      child: CircleAvatar(
                        backgroundColor:
                            ColorValues.blackColor.withOpacity(0.75),
                        radius: Dimens.sixTeen,
                        child: Icon(
                          Icons.picture_in_picture_alt,
                          color: Colors.white,
                          size: Dimens.sixTeen,
                        ),
                      ),
                      onTap: () => setState(() {
                        widget.controller!.enablePictureInPicture(
                            widget.controller!.betterPlayerGlobalKey!);
                      }),
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: Dimens.edgeInsets8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (widget.controller!.isPlaying()!) {
                        widget.controller!.pause();
                      } else {
                        widget.controller!.play();
                      }
                    });
                  },
                  child: Icon(
                    widget.controller!.isPlaying()!
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                    color: ColorValues.whiteColor,
                    size: widget.isSmallPlayer
                        ? Dimens.twentyEight
                        : Dimens.thirtyTwo,
                  ),
                ),
                RichText(
                  text: TextSpan(text: widget.timeLeft),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
