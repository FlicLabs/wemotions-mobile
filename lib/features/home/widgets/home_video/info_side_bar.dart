import 'package:socialverse/export.dart';

class InfoSideBar extends StatelessWidget {
  const InfoSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    
    return Consumer<HomeProvider>(
      builder: (_, home, __) {
        final post = home.posts[home.index][0];

        return Positioned(
          left: 16,
          bottom: video.downloading == true || video.downloadingCompleted ? 30 : 45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    UserProfileScreen.routeName,
                    arguments: UserProfileScreenArgs(username: post.username),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image with Subtle Glow
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 200),
                          fadeOutDuration: Duration(milliseconds: 200),
                          fit: BoxFit.cover,
                          height: 45,
                          width: 45,
                          imageUrl: post.pictureUrl,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 22,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: SvgPicture.asset(
                              AppAsset.icuser,
                              color: Theme.of(context).cardColor,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    
                    // Username
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.username,
                          style: AppTextStyle.normalRegular16.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Video Title
              if (post.title.isNotEmpty) 
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: cs().width(context) - 100,
                  child: GestureDetector(
                    onTap: () => home.toggleTextExpanded(),
                    child: Linkify(
                      onOpen: (link) async {
                        if (await canLaunchUrl(Uri.parse(link.url))) {
                          await launchUrl(Uri.parse(link.url));
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      text: post.title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.normalRegular.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: home.isTextExpanded ? 5 + (6 * home.expansionProgress).round() : 1,
                      linkStyle: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

