import 'package:socialverse/export.dart';

class TagPeopleWidget extends StatelessWidget {
  const TagPeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (_, postProvider, __) {
        return Container(
          height: cs().height(context) / 1.45,
          width: cs().width(context),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const Divider(height: 0),
              height15,
              _buildSearchField(postProvider, context),
              height15,
              Expanded(
                child: ListView.builder(
                  itemCount: postProvider.searchController.text.isEmpty
                      ? postProvider.selected_users.length
                      : postProvider.searched_users.length,
                  itemBuilder: (context, index) {
                    final user = postProvider.searchController.text.isEmpty
                        ? postProvider.selected_users[index]
                        : postProvider.searched_users[index];

                    if (user.username == prefs_username) {
                      return const SizedBox.shrink();
                    }
                    return _buildUserTile(user, postProvider, context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: cs().width(context),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "Tag someone",
            style: AppTextStyle.normalSemiBold20Black.copyWith(
              color: Theme.of(context).focusColor,
            ),
          ),
          Positioned(
            right: 10,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close,
                color: Colors.grey.shade600,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(PostProvider postProvider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: postProvider.searchController,
        decoration: textFormFieldDecoration.copyWith(
          hintText: 'Enter name here please',
          fillColor: Colors.transparent,
          hintStyle: AppTextStyle.displaySmall.copyWith(
            color: Theme.of(context).indicatorColor,
          ),
          errorStyle: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontSize: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFA858F4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 13),
        onChanged: postProvider.onSearchChanged,
      ),
    );
  }

  Widget _buildUserTile(User user, PostProvider postProvider, BuildContext context) {
    return GestureDetector(
      onTap: () {
        postProvider.selectUsers(user);
        postProvider.searched_users.clear();
        postProvider.searchController.clear();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          title: Text(
            '${user.firstName} ${user.lastName}',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14),
          ),
          subtitle: Text(
            user.username,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 0),
              fadeOutDuration: const Duration(milliseconds: 0),
              fit: BoxFit.cover,
              height: 45,
              width: 45,
              imageUrl: user.profilePictureUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Image.asset(AppAsset.load, fit: BoxFit.cover, height: cs().height(context)),
              errorWidget: (context, url, error) => Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(AppAsset.icuser, color: Theme.of(context).cardColor),
              ),
            ),
          ),
          trailing: postProvider.selected_users.contains(user.username)
              ? const Icon(Icons.remove_rounded, size: 35)
              : null,
        ),
      ),
    );
  }
}
