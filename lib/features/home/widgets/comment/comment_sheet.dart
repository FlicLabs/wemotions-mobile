import 'dart:developer';
import 'package:socialverse/export.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    // final VideoProvider video = Provider.of<VideoProvider>(context);
    final HomeProvider home = Provider.of<HomeProvider>(context);
    DateTime formatTimestamp(int timestamp) {
      var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
      return date;
    }

    return Consumer<CommentProvider>(
      builder: (_, __, ___) {
        final user = Provider.of<UserProfileProvider>(context);
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView.builder(
            itemCount: __.comment_list.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 80,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (home.videoController(home.index)!.value.isPlaying) {
                          home.videoController(home.index)!.pause();
                        }
                        user.page = 1;
                        user.posts.clear();
                        user.user = ProfileModel.empty;
                        Navigator.of(context)
                            .pushNamed(
                              UserProfileScreen.routeName,
                              arguments: UserProfileScreenArgs(
                                username: __.comment_list[index].username,
                                isFollowing: (isFollow) {},
                              ),
                            )
                            .then(
                              (value) =>
                                  home.videoController(home.index)!.play(),
                            );
                      },
                      child: CustomCircularAvatar(
                        imageUrl: __.comment_list[index].pictureUrl,
                        height: 48,
                        width: 48,
                      ),
                    ),
                    width10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (home
                                  .videoController(home.index)!
                                  .value
                                  .isPlaying) {
                                home.videoController(home.index)!.pause();
                              }
                              user.page = 1;
                              user.posts.clear();
                              user.user = ProfileModel.empty;
                              Navigator.of(context)
                                  .pushNamed(
                                    UserProfileScreen.routeName,
                                    arguments: UserProfileScreenArgs(
                                      username: __.comment_list[index].username,
                                      isFollowing: (isFollow) {},
                                    ),
                                  )
                                  .then(
                                    (value) => home
                                        .videoController(home.index)!
                                        .play(),
                                  );
                              log(__.comment_list[index].username);
                            },
                            child: Text(
                              __.comment_list[index].username,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                          height2,
                          Text(
                            __.comment_list[index].body,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 12),
                          ),
                          height5,
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          formatTimestamp(
                            __.comment_list[index].createdAt,
                          ).time_ago(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 12),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (logged_in == true) {
                                  if (__.comment_list[index].upvoted == false) {
                                    __.upvoteComment(
                                        comment_id: __.comment_list[index].id);
                                  } else if (__.comment_list[index].upvoted ==
                                      true) {
                                    __.removeUpvoteComment(
                                        comment_id: __.comment_list[index].id);
                                  }
                                } else {
                                  auth.showAuthBottomSheet(context);
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 30,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      __.comment_list[index].upvoted == true
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          __.comment_list[index].upvoted == true
                                              ? Colors.red
                                              : Colors.grey,
                                      size: 18,
                                    ),
                                    width5,
                                    Expanded(
                                      child: Text(
                                        '${__.comment_list[index].upvoteCount}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
