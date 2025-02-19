import 'package:socialverse/export.dart';

class ListHolder extends StatelessWidget {
  const ListHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: cs.height(context) * 0.115,
      ),
      children: [
        ListPlaceholder(),
        ListPlaceholder(),
        ListPlaceholder(),
        ListPlaceholder(),
        ListPlaceholder(),
        ListPlaceholder(),
        ListPlaceholder(),
        ListPlaceholder(),
        ListPlaceholder(),
        ListPlaceholder(),
      ],
    );
  }
}
