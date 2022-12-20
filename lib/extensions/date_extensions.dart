import 'package:intl/intl.dart';

const String dateFormatter = 'dd MMM';
const String timeFormatter = 'hh:mm a';
const String longDateFormatter = 'dd MMM yyyy';

extension DateHelper on DateTime {
  String formatDate() {
    var diff = DateTime.now().toLocal().difference(toLocal());

    if (diff > const Duration(days: 365)) {
      return DateFormat(longDateFormatter).format(toLocal());
    } else if (isSameDate(DateTime.now()) && diff <= const Duration(days: 1)) {
      return 'Today';
    } else {
      return DateFormat(dateFormatter).format(toLocal());
    }
  }

  String getTime({bool is24Hour = false, bool showSeconds = false}) {
    var toLocal = this.toLocal();
    var hr = toLocal.hour;
    var min = toLocal.minute;
    var sec = toLocal.second;

    var hrStr = hr < 10 ? '0$hr' : '$hr';
    var minStr = min < 10 ? '0$min' : '$min';
    var secStr = sec < 10 ? '0$sec' : '$sec';

    var time = '$hrStr:$minStr';

    if (!is24Hour) {
      if (hr > 12) {
        hrStr = (hr - 12).toString();
        hrStr = hrStr.length == 1 ? '0$hrStr' : hrStr;
      } else if (hr == 0) {
        hrStr = '12';
      }
      time = '$hrStr:$minStr';
    }

    if (showSeconds) {
      time += ':$secStr';
    }

    if (!is24Hour) {
      time += ' ${hr >= 12 ? 'PM' : 'AM'}';
    }

    return time;
  }

  bool isSameDate(DateTime other) {
    return toLocal().year == other.toLocal().year &&
        toLocal().month == other.toLocal().month &&
        toLocal().day == other.toLocal().day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now().toLocal();
    return now.difference(toLocal()).inDays;
  }

  String getDateTime() {
    return DateFormat('dd MMM yyyy hh:mm a').format(toLocal());
  }
}
