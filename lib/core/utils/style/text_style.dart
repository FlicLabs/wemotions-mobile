import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  /// 📌 **Body Text Styles**
  static const bodyMedium = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  static const bodyLarge = TextStyle(fontFamily: 'sofia', fontSize: 18, fontWeight: FontWeight.w700);
  static const bodySmall = TextStyle(fontFamily: 'sofia', fontSize: 14, fontWeight: FontWeight.w100);

  /// 📌 **Headline Styles**
  static const headlineMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const headlineSmall = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, fontFamily: 'sofia');

  /// 📌 **Subheadline & Display Styles**
  static const subheadlineMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'sofia');
  static const displaySmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'sofia', color: Colors.grey);
  static const displayMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'sofia');

  /// 📌 **Label Styles**
  static const labelSmall = TextStyle(fontSize: 10, fontWeight: FontWeight.w400, fontFamily: 'sofia');
  static const labelMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'sofia');
  static const labelLarge = TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'sofia');

  /// 📌 **Normal Text Styles (White by Default)**
  static TextStyle normalRegular({double size = 14, Color color = Colors.white, FontWeight weight = FontWeight.w100}) {
    return TextStyle(fontFamily: 'sofia', fontSize: size, fontWeight: weight, color: color);
  }

  static TextStyle normalBold({double size = 14, Color color = Colors.white}) {
    return TextStyle(fontFamily: 'sofia', fontSize: size, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle normalSemiBold({double size = 14, Color color = Colors.white}) {
    return TextStyle(fontFamily: 'sofia', fontSize: size, fontWeight: FontWeight.w600, color: color);
  }
}

