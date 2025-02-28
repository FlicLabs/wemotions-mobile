import 'package:socialverse/export.dart';

class PostTagTile extends StatelessWidget {
  const PostTagTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (_, __, ___) {
        return GestureDetector(
          onTap: (){
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              builder: (context) {
                return TagPeopleWidget();
              },
            ).whenComplete(() {
              // __.searched_users.clear();
              // __.searchController.clear();
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppAsset.ictaguser,
                    height: 23,
                    width: 23,
                    color: Theme.of(context).focusColor,
                    fit: BoxFit.cover,
                  ),
                width5,
                  Text(
                    'Tag people',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),

                ],
              ),
              Row(
                children: [
                  if(__.selected_users.isNotEmpty)...[
                    if(__.selected_users.length > 1)...[
                      Text(__.selected_users.length.toString()+" people")
                    ]else...[
                      Text(__.selected_users.first.username)
                    ]
                  ],
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
