import 'package:intl/intl.dart';

extension DateStringExtensions on String {
  String toCustomTimeString() {
    final List<DateFormat> dateFormats = [
      DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS'), // With microseconds
      DateFormat('yyyy-MM-dd HH:mm:ss'),        // Without microseconds
      DateFormat("yyyy-MM-dd'T'HH:mm:ss"),      // ISO 8601 without timezone
      DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'"),   // ISO 8601 with UTC timezone
    ];
    
    DateTime? dateTime;

    for (var format in dateFormats) {
      try {
        dateTime = format.parse(this, true).toLocal();
        break; // Stop if parsing is successful
      } catch (_) {}
    }

    if (dateTime == null) return "Invalid date";

    DateTime now = DateTime.now();
    final int difference = now.difference(dateTime).inDays;

    return switch (difference) {
      0 => DateFormat('HH:mm').format(dateTime), // Today → Show time
      1 => "Yesterday",                          // Yesterday → Show "Yesterday"
      _ when difference < 7 => DateFormat.EEEE().format(dateTime), // Past week → Show day name
      _ => DateFormat('MM/dd').format(dateTime)  // Older than a week → Show "MM/dd"
    };
  }
}

String formatDate(String dateString) {
  try {
    final DateTime date = DateTime.parse(dateString).toLocal();
    final int difference = DateTime.now().difference(date).inDays;

    return switch (difference) {
      0 => "Today",
      1 => "Yesterday",
      _ when difference < 7 => DateFormat.EEEE().format(date), // Within a week → Show day name
      _ => DateFormat('MM/dd').format(date)  // Older → Show MM/dd
    };
  } catch (e) {
    return "Invalid date";
  }
}

