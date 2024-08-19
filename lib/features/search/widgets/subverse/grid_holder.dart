import 'package:socialverse/export.dart';

class GridHolder extends StatelessWidget {
  const GridHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 3.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: cs().height(context) * 0.115,
      ),
      children: [
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
        GridPlaceholder(),
      ],
    );
  }
}
