import 'package:socialverse/export.dart';

class TaggingWidget extends StatefulWidget {
  const TaggingWidget({Key? key}) : super(key: key);

  @override
  State<TaggingWidget> createState() => _TaggingWidgetState();
}

class _TaggingWidgetState extends State<TaggingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, homeProvider, __) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            height: cs().height(context) / 1.45,
            width: cs().width(context),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                Divider(color: Colors.grey.shade400, height: 0),
                _buildSearchBar(homeProvider),
                SizedBox(height: 10),
                _buildUserList(homeProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "Tag Someone",
            style: AppTextStyle.normalSemiBold20Black.copyWith(
              color: Theme.of(context).focusColor,
            ),
          ),
          Positioned(
            right: 0,
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

  Widget _buildSearchBar(HomeProvider homeProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: homeProvider.searchController,
        decoration: textFormFieldDecoration.copyWith(
          hintText: 'Enter name here...',
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
          fillColor: Colors.transparent,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFA858F4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        onChanged: (value) => homeProvider.onSearchChanged(value),
      ),
    );
  }

  Widget _buildUserList(HomeProvider homeProvider) {
    List users = homeProvider.searchController.text.isEmpty
        ? homeProvider.selected_users
        : homeProvider.searched_users;

    return Expanded(
      child: users.isEmpty
          ? Center(child: Text("No users found", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                if (user.username == prefs_username ||
                    homeProvider.posts[homeProvider.index][0].tags.any((tag) =>
                        tag.user.username == user.username)) {
                  return Container();
                }

                return _buildUserTile(user, homeProvider);
              },
            ),
    );
  }

  Widget _buildUserTile(dynamic user, HomeProvider homeProvider) {
    return GestureDetector(
      onTap: () {
        homeProvider.selectUsers(homeProvider.posts[homeProvider.index][0].id, user);
        homeProvider.searched_users.clear();
        homeProvider.searchController.clear();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            "${user.firstName} ${user.lastName}",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            "@${user.username}",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: 40,
              height: 40,
              imageUrl: user.profilePictureUrl,
              placeholder: (context, url) => CircularProgressIndicator(strokeWidth: 2),
              errorWidget: (context, url, error) => CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: SvgPicture.asset(AppAsset.icuser, color: Colors.white, width: 20),
              ),
            ),
          ),
          trailing: Icon(
            Icons.person_add,
            color: Color(0xFFA858F4),
            size: 22,
          ),
        ),
      ),
    );
  }
}

