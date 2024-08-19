import 'package:socialverse/features/chat/utils/chip_text.dart';

abstract class Algo {
  Algo._();

  static String dateChipText(final DateTime date) {
    final dateChipText = new DateChipText(date);
    return dateChipText.getText();
  }
}
