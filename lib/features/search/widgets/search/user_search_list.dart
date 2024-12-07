import 'package:socialverse/export.dart';

class UserSearchList extends StatelessWidget {
  const UserSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    return Consumer<SearchProvider>(
      builder: (_, __, ___) {
        if (__.search.text.isNotEmpty && __.user_search.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAsset.icsearchlarge,
                color: Theme.of(context).indicatorColor,
              ),
              Text(
                "It seems we can't find the user\n you're looking for. Try another\n search.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          );
        }
        return ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          itemCount: __.user_search.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  UserProfileScreen.routeName,
                  arguments: UserProfileScreenArgs(
                    username: __.user_search[index].username,
                  ),
                );
              },
              child: Container(
                height: 65,
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: cs().width(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCircularAvatar(
                      imageUrl: __.user_search[index].profilePictureUrl,
                      height: 55,
                      width: 55,
                    ),
                    width10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          __.user_search[index].username,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        height5,
                        // Text(
                        //   __.user_search[index].firstName +
                        //       ' ' +
                        //       __.user_search[index].lastName,
                        //   style: Theme.of(context).textTheme.labelMedium,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
