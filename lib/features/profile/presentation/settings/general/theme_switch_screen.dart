import 'package:socialverse/export.dart';

class AppTheme {
  ThemeMode mode;
  String title;
  IconData icon;

  AppTheme({
    required this.mode,
    required this.title,
    required this.icon,
  });
}

class ThemeSwitchScreen extends StatelessWidget {
  static const String routeName = '/theme-switch';
  const ThemeSwitchScreen({super.key});

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ThemeSwitchScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    //group value for radio button
    var _groupValue = Provider.of<ThemeProvider>(context).selectedThemeMode;

    List<AppTheme> appThemes = [
      AppTheme(
        mode: ThemeMode.light,
        title: 'Light Mode',
        icon: Icons.brightness_5_rounded,
      ),
      AppTheme(
        mode: ThemeMode.dark,
        title: 'Dark Mode',
        icon: Icons.brightness_2_rounded,
      ),
      AppTheme(
        mode: ThemeMode.system,
        title: 'System Default',
        icon: Icons.brightness_4_rounded,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Theme',
          style: AppTextStyle.normalBold24
              .copyWith(color: Theme.of(context).focusColor),
          textAlign: TextAlign.start,
        ),
      ),
      body: SafeArea(
        child: Consumer<ThemeProvider>(
          builder: (_, __, ___) => Column(
            children: List.generate(
              appThemes.length,
              (i) {
                bool _isSelectedTheme =
                    appThemes[i].mode == __.selectedThemeMode;
                return GestureDetector(
                  onTap: () {
                    if (_isSelectedTheme) {
                      return null;
                    } else {
                      HapticFeedback.mediumImpact();
                      __.setSelectedThemeMode(appThemes[i].mode);
                    }
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: _isSelectedTheme
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          // vertical: 7,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                fillColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Theme.of(context).hintColor;
                                  }
                                  return Theme.of(context).indicatorColor;
                                }),
                                value: appThemes[i].mode,
                                groupValue: _groupValue,
                                onChanged: (value) {
                                  __.setSelectedThemeMode(
                                    value as ThemeMode,
                                  );
                                },
                              ),
                            ),
                            width2,
                            Text(
                              appThemes[i].title,
                              style: AppTextStyle.normalRegular18.copyWith(
                                  color: Theme.of(context).focusColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
