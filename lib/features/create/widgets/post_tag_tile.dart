import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/widgets/tagpeople_widget.dart';

class PostTagTile extends StatelessWidget {
  const PostTagTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              builder: (_) => const TagPeopleWidget(),
            ).whenComplete(() {
              postProvider.searched_users.clear();
              postProvider.searchController.clear();
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppAsset.ictaguser,
                    height: 23,
                    width: 23,
                    color: Theme.of(context).focusColor,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Tag people',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  if (postProvider.selected_users.isNotEmpty)
                    Text(
                      postProvider.selected_users.length > 1
                          ? '${postProvider.selected_users.length} people'
                          : postProvider.selected_users.first.username,
                    ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Theme.of(context).focusColor,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
