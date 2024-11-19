import 'package:socialverse/export.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 18,
      leading: shrink,
      leadingWidth: 0,
      title: Row(
        children: [
          Expanded(
            child: SearchBar(
              onTap: () {
                Navigator.of(context).pushNamed(SearchScreen.routeName);
              },
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}

