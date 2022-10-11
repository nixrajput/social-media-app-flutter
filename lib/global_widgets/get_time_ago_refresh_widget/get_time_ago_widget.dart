import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/global_widgets/get_time_ago_refresh_widget/timer_refresh_widget.dart';

typedef TimeagoBuilder = Widget Function(BuildContext context, String value);

class GetTimeAgoWidget extends TimerRefreshWidget {
  const GetTimeAgoWidget({
    Key? key,
    required this.builder,
    required this.date,
    this.locale,
    this.pattern,
    Duration refreshRate = const Duration(minutes: 1),
  }) : super(key: key, refreshRate: refreshRate);

  final TimeagoBuilder builder;
  final DateTime date;
  final String? locale;
  final String? pattern;

  @override
  Widget build(BuildContext context) {
    final formatted = GetTimeAgo.parse(
      date,
      locale: locale,
      pattern: pattern,
    );
    return builder(context, formatted);
  }
}
