import 'package:socialverse/export.dart';

class AltTaggingSheet extends StatefulWidget {
  const AltTaggingSheet({super.key});

  @override
  State<AltTaggingSheet> createState() => _AltTaggingSheetState();
}

class _AltTaggingSheetState extends State<AltTaggingSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Color> bgColors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.greenAccent,
    Constants.primaryColor,
  ];

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
            width: cs().width(context),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 15),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: homeProvider.posts[homeProvider.index][0].tags
                      .map((e) => _buildTagChip(e))
                      .toList(),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagChip(dynamic tag) {
    return Chip(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      backgroundColor: bgColors[tag.user.username.hashCode % bgColors.length],
      shadowColor: Colors.black45,
      avatar: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          width: 32,
          height: 32,
          imageUrl: tag.user.pictureUrl,
          placeholder: (context, url) => CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: SvgPicture.asset(
              AppAsset.icuser,
              color: Colors.white,
              width: 20,
            ),
          ),
        ),
      ),
      label: Text(
        tag.user.username,
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
      deleteIcon: Icon(Icons.cancel, size: 18, color: Colors.white),
      onDeleted: () {
        // homeProvider.removeTag(homeProvider.posts[homeProvider.index][0].id, tag.user);
      },
    );
  }
}
