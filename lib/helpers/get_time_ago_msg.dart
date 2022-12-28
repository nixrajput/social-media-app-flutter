import 'package:get_time_ago/get_time_ago.dart';

class CustomMessages implements Messages {
  @override
  String prefixAgo() => '';

  @override
  String suffixAgo() => 'ago';

  @override
  String secsAgo(int seconds) => '${seconds}s';

  @override
  String minAgo(int minutes) => '1m';

  @override
  String minsAgo(int minutes) => '${minutes}m';

  @override
  String hourAgo(int minutes) => '1h';

  @override
  String hoursAgo(int hours) => '${hours}h';

  @override
  String dayAgo(int hours) => '1d';

  @override
  String daysAgo(int days) => '${days}d';

  @override
  String wordSeparator() => ' ';
}
