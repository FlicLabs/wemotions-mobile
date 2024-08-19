import 'package:socialverse/export.dart';

class Bio extends StatelessWidget {
  const Bio({Key? key, required this.bio}) : super(key: key);

  final String bio;

  @override
  Widget build(BuildContext context) {
    return bio.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
              top: 10,
            ),
            child: Text(
              bio,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          )
        : shrink;
  }
}
