import 'package:socialverse/export.dart';

class Constants {
  static String appName = "WeMotions";

  static Color lightPrimary = Colors.white;
  //static Color lightSecondary = Color(0xfffafafa);
  static Color darkPrimary = Colors.black;

  static Color primaryColor = Color(0xFFA858F4);

  static Color primaryGrey = Colors.grey.shade100;
  static Color secondaryGrey = Colors.grey.shade900;
  static Color tertiaryGrey = Colors.grey.shade600;
  static Color tertiaryGrey800 = Colors.grey.shade800;
  static Color primaryGrey500 = Colors.grey.shade500;
  static Color tabBarGrey = Colors.grey.withOpacity(0.5);
  static Color whiteAndBlackRich= Color.fromRGBO(41, 41, 41, 1);
  static Color whiteAndBlack= Color.fromRGBO(61, 61, 61, 1);


  static Color fillGrey = Color(0xff2B2B2B);

  static ThemeData lightTheme = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Color.fromRGBO(0, 0, 0, 0),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: lightPrimary,
      elevation: 0,
      iconTheme: IconThemeData(color: darkPrimary),
    ),
    textTheme: TextTheme(
      bodyMedium: AppTextStyle.bodyMedium.copyWith(color: darkPrimary),
      bodyLarge: AppTextStyle.bodyLarge.copyWith(color: darkPrimary),
      headlineMedium: AppTextStyle.headlineMedium.copyWith(color: darkPrimary),
      displaySmall: AppTextStyle.displaySmall.copyWith(color: primaryGrey500),
      displayMedium: AppTextStyle.displayMedium.copyWith(color: darkPrimary),
      headlineSmall: AppTextStyle.headlineSmall.copyWith(color: tertiaryGrey),
      labelMedium: AppTextStyle.labelMedium.copyWith(color: darkPrimary),
      labelLarge: AppTextStyle.labelLarge.copyWith(color: darkPrimary),
      labelSmall: AppTextStyle.labelSmall.copyWith(color: primaryGrey500),
    ),
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
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: lightPrimary)
        .copyWith(background: lightPrimary),
  );

  static ThemeData darkTheme = ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: darkPrimary,
      elevation: 0,
      iconTheme: IconThemeData(color: lightPrimary),
    ),
    textTheme: TextTheme(
      bodyMedium: AppTextStyle.bodyMedium.copyWith(color: lightPrimary),
      bodyLarge: AppTextStyle.bodyLarge.copyWith(color: lightPrimary),
      displaySmall: AppTextStyle.displaySmall.copyWith(color: primaryGrey500),
      displayMedium: AppTextStyle.displayMedium.copyWith(color: lightPrimary),
      headlineSmall: AppTextStyle.headlineSmall.copyWith(color: tertiaryGrey),
      headlineMedium: AppTextStyle.headlineMedium.copyWith(color: lightPrimary),
      labelMedium: AppTextStyle.labelMedium.copyWith(color: lightPrimary),
      labelLarge: AppTextStyle.labelLarge.copyWith(color: lightPrimary),
      labelSmall: AppTextStyle.labelSmall.copyWith(color: primaryGrey500),
    ),
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
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: darkPrimary)
        .copyWith(background: darkPrimary),
  );
}
