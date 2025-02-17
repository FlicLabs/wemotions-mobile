import 'package:flutter/material.dart';
import 'package:socialverse/core/utils/style/text_style.dart';

class Constants {
  /// 📌 **App Name**
  static const String appName = "Socialverse";

  /// 📌 **Primary Colors**
  static const Color primaryColor = Color(0xFFA858F4);
  static const Color lightPrimary = Colors.white;
  static const Color darkPrimary = Colors.black;

  /// 📌 **Greyscale Colors**
  static final Color primaryGrey = Colors.grey.shade100;
  static final Color secondaryGrey = Colors.grey.shade900;
  static final Color tertiaryGrey = Colors.grey.shade600;
  static final Color tertiaryGrey800 = Colors.grey.shade800;
  static final Color primaryGrey500 = Colors.grey.shade500;
  static final Color tabBarGrey = Colors.grey.withOpacity(0.5);

  /// 📌 **Other Colors**
  static const Color fillGrey = Color(0xff2B2B2B);

  /// 📌 **Common Text Theme**
  static TextTheme _baseTextTheme(Color textColor) => TextTheme(
        bodyMedium: AppTextStyle.bodyMedium.copyWith(color: textColor),
        bodyLarge: AppTextStyle.bodyLarge.copyWith(color: textColor),
        headlineMedium: AppTextStyle.headlineMedium.copyWith(color: textColor),
        displaySmall: AppTextStyle.displaySmall.copyWith(color: primaryGrey500),
        displayMedium: AppTextStyle.displayMedium.copyWith(color: textColor),
        headlineSmall: AppTextStyle.headlineSmall.copyWith(color: tertiaryGrey),
        labelMedium: AppTextStyle.labelMedium.copyWith(color: textColor),
        labelLarge: AppTextStyle.labelLarge.copyWith(color: textColor),
        labelSmall: AppTextStyle.labelSmall.copyWith(color: primaryGrey500),
      );

  /// 📌 **Light Theme**
  static final ThemeData lightTheme = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: lightPrimary,
      elevation: 0,
      iconTheme: const IconThemeData(color: darkPrimary),
    ),
    textTheme: _baseTextTheme(darkPrimary),
    fontFamily: 'sofia',
    scaffoldBackgroundColor: lightPrimary,
    primaryColor: lightPrimary,
    focusColor: darkPrimary,
    hoverColor: primaryGrey,
    indicatorColor: secondaryGrey,
    hintColor: primaryColor,
    cardColor: tabBarGrey,
    canvasColor: lightPrimary,
    primaryColorDark: primaryGrey500,
    shadowColor: lightPrimary,
    disabledColor: primaryGrey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: lightPrimary,
      background: lightPrimary,
    ),
  );

  /// 📌 **Dark Theme**
  static final ThemeData darkTheme = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: darkPrimary,
      elevation: 0,
      iconTheme: const IconThemeData(color: lightPrimary),
    ),
    textTheme: _baseTextTheme(lightPrimary),
    fontFamily: 'sofia',
    scaffoldBackgroundColor: darkPrimary,
    primaryColor: darkPrimary,
    focusColor: lightPrimary,
    hoverColor: secondaryGrey,
    indicatorColor: primaryGrey,
    hintColor: primaryColor,
    cardColor: tabBarGrey,
    canvasColor: fillGrey,
    primaryColorDark: primaryGrey500,
    shadowColor: secondaryGrey,
    disabledColor: tertiaryGrey800,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: darkPrimary,
      background: darkPrimary,
    ),
  );
}
