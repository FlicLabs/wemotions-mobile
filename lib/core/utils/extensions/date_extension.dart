import 'package:intl/intl.dart';

extension DateStringExtensions on String {
  String toCustomTimeString() {
    final DateFormat formatterWithMicroseconds =
        DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS');
    final DateFormat formatterWithoutMicroseconds =
        DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime dateTime;

    try {
      // Try parsing with microseconds first
      dateTime = formatterWithMicroseconds.parse(this);
    } catch (e) {
      try {
        // If parsing with microseconds fails, try without microseconds
        dateTime = formatterWithoutMicroseconds.parse(this);
      } catch (e) {
        // If both parsing attempts fail, return "Invalid date"
        return "Invalid date";
      }
    }

    DateTime now = DateTime.now();
    final difference = now.difference(dateTime).inDays;

    if (difference == 0) {
      // If it's today, return the actual time
      return DateFormat('HH:mm').format(dateTime);
    } else if (difference == 1) {
      // If it's yesterday, return "Yesterday"
      return "Yesterday";
    } else if (difference < 7) {
      // If it's within the last week, return the day of the week
      return DateFormat.EEEE().format(dateTime); // Name of the day
    } else {
      // Older than a week, return in MM/dd format
      return DateFormat('MM/dd').format(dateTime);
    }
  }
}

String formatDate(String dateString) {
  // Assuming the date string is in the format 'yyyy-MM-ddTHH:mm:ss'
  final DateTime date = DateTime.parse(dateString);

  final now = DateTime.now();
  final difference = now.difference(date).inDays;

  if (difference == 0) {
    return 'Today';
  } else if (difference == 1) {
    return 'Yesterday';
  } else if (difference < 7) {
    return DateFormat.EEEE()
        .format(date); // Return the day of the week (e.g., "Tuesday")
  } else {
    return DateFormat('MM/dd').format(date); // Return the date in MM/dd format
  }
}
