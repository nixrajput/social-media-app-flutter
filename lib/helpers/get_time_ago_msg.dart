import 'package:get_time_ago/get_time_ago.dart';

const customMessages = TimeAgoLocale(
  intlLocale: 'en',
  long: TimeAgoPatterns(
    justNow: 'now',
    units: {
      TimeUnit.second: RelativePatterns(
        past: Plural(other: '{0}s ago'),
        future: Plural(other: 'in {0}s'),
      ),
      TimeUnit.minute: RelativePatterns(
        past: Plural(other: '{0}m ago'),
        future: Plural(other: 'in {0}m'),
      ),
      TimeUnit.hour: RelativePatterns(
        past: Plural(other: '{0}h ago'),
        future: Plural(other: 'in {0}h'),
      ),
      TimeUnit.day: RelativePatterns(
        past: Plural(other: '{0}d ago'),
        future: Plural(other: 'in {0}d'),
      ),
    },
  ),
);
