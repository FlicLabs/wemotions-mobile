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
        title: 'Light',
        icon: Icons.brightness_5_rounded,
      ),
      AppTheme(
        mode: ThemeMode.dark,
        title: 'Dark',
        icon: Icons.brightness_2_rounded,
      ),
      AppTheme(
        mode: ThemeMode.system,
        title: 'System',
        icon: Icons.brightness_4_rounded,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Theme',
          style: Theme.of(context).textTheme.bodyLarge,
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
                    height: 80,
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
                          horizontal: 15,
                          vertical: 7,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).hoverColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              appThemes[i].title,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Radio(
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
