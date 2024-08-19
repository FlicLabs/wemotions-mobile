import 'package:socialverse/export.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          ThemeSwitchScreen.routeName,
        );
      },
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      leading: const Icon(
        Icons.dark_mode_outlined,
        color: Colors.grey,
      ),
      title: Text(
        'Theme',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right_sharp,
        color: Theme.of(context).focusColor,
      ),
    );
  }
}
