import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension TimeAgo on DateTime {
  String time_ago() {
    final currentDate = DateTime.now();
    if (currentDate.difference(this).inDays > 1) {
      return DateFormat.Md().format(this);
    }
    return timeago.format(this);
  }
}

extension DayMonthExtension on DateTime {
  String day_month() {
    return DateFormat.Md().format(this);
  }
}
