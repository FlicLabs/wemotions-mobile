import 'package:socialverse/export.dart';

class UserSearchList extends StatelessWidget {
  const UserSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, provider, __) {
        if (provider.search.text.isNotEmpty && provider.user_search.isEmpty) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 200,
                    color: Theme.of(context).indicatorColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "It seems we can't find the user\nyou're looking for. Try another search.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: provider.user_search.length,
          itemBuilder: (context, index) {
            return _buildUserTile(context, provider, index);
          },
        );
      },
    );
  }

  /// Extracted function for better readability
  Widget _buildUserTile(BuildContext context, SearchProvider provider, int index) {
    final user = provider.user_search[index];

    return GestureDetector(
      onTap: () => _navigateToUserProfile(context, user.username),
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity, // Ensures full width
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCircularAvatar(
              imageUrl: user.profilePictureUrl,
              height: 55,
              width: 55,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.username,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Extracted navigation function for clarity
  void _navigateToUserProfile(BuildContext context, String username) {
    Navigator.of(context).pushNamed(
      UserProfileScreen.routeName,
      arguments: UserProfileScreenArgs(username: username),
    );
  }
}
