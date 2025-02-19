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
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: SvgPicture.asset(
                    AppAsset.search,
                    color: Constants.primaryGrey500,
                    width: cs.width(context)/2,
                    height: cs.height(context)/3,
                  ),
                ),
                Text(
                  "It seems we can't find the user\n you're looking for. Try another\n search.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Constants.primaryGrey500,fontWeight: FontWeight.bold,fontSize: 20),
                ),
              ],
            ),
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
                ).then((value) => {
                __.assignToSearch(__.user_search[index]),
                });

              },
              child: Container(
                height: 65,
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: cs.width(context),
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
