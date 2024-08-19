import 'package:socialverse/export.dart';

class GridViewButton extends StatelessWidget {
  const GridViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, __, ___) {
        return GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (__.isGridView == true) {
              prefs.setBool("grid_view", false);
              __.isGridView = false;
            } else {
              prefs.setBool("grid_view", true);
              __.isGridView = true;
            }
          },
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: __.isGridView == false
                ? Icon(Icons.list, color: Theme.of(context).focusColor)
                : Icon(Icons.grid_view, color: Theme.of(context).focusColor),
          ),
        );
      },
    );
  }
}
