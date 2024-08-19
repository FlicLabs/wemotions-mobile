import 'package:socialverse/export.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (_, __, ___) {
        return ListTile(
          horizontalTitleGap: 1,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          leading: SvgPicture.asset(
            AppAsset.sphereLogo,
            height: 23,
            width: 23,
            color: Colors.grey,
            fit: BoxFit.cover,
          ),
          title: Text(
            'Subverse',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          trailing: Text(
            '${__.subverse_name}',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.end,
          ),
        );
      },
    );
  }
}
