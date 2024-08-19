// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:socialverse/export.dart';
import 'package:socialverse/core/utils/constants/constants.dart';

class DynamicLinkRepository {
  static final DynamicLinkRepository _dynamicLinkRepository =
      DynamicLinkRepository._internal();
  factory DynamicLinkRepository() {
    return _dynamicLinkRepository;
  }
  DynamicLinkRepository._internal();

  Future<String> createSubverseLink({
    String? title,
    String? description,
    String? imageUrl,
    String? id,
    String? count,
    bool? isPost,
    bool? isSubverse,
    bool? isProfile,
  }) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
        'https://holyvible.com/?isPost=$isPost&isSubverse=$isSubverse&isProfile=$isProfile&id=$id&title=$title&desc=$description&imageUrl=$imageUrl&count=$count',
      ),
      uriPrefix: 'https://holyvible.page.link',
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(imageUrl ?? ''),
      ),
      androidParameters: const AndroidParameters(
        packageName: 'com.subverse.vible',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.subverse.vible',
        appStoreId: '6444683138',
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    log(dynamicLink.shortUrl.toString());
    return dynamicLink.shortUrl.toString();
  }

  Future<String> createInviteLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
        'https://holyvible.com/',
      ),
      uriPrefix: 'https://holyvible.page.link',
      socialMetaTagParameters: SocialMetaTagParameters(
        title: '$prefs_username invited you to join Vible',
        imageUrl: Uri.parse(holy_image),
      ),
      androidParameters: const AndroidParameters(
        packageName: 'com.subverse.vible',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.subverse.vible',
        appStoreId: '6444683138',
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    log(dynamicLink.shortUrl.toString());
    return dynamicLink.shortUrl.toString();
  }

  Future<String> createProfileLink({
    String? followers,
    String? following,
    String? posts,
    String? imageUrl,
    String? username,
    String? first_name,
    bool? isPost,
    bool? isSubverse,
    bool? isProfile,
  }) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
        'https://holyvible.com/?isPost=$isPost&isSubverse=$isSubverse&isProfile=$isProfile&imageUrl=$imageUrl&username=$username&firstname=$first_name&followers=$followers&following=$following&posts=$posts',
      ),
      uriPrefix: 'https://holyvible.page.link',
      socialMetaTagParameters: SocialMetaTagParameters(
        title: '$first_name on Vible',
        description:
            '@${username}, Followers: $followers, Following: $following, Posts: $posts - Join Holy Vible and see what Holy Vible users have been up to!',
        imageUrl: Uri.parse(imageUrl ?? ''),
      ),
      androidParameters: const AndroidParameters(
        packageName: 'com.subverse.vible',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.subverse.vible',
        appStoreId: '6444683138',
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    log(dynamicLink.shortUrl.toString());
    return dynamicLink.shortUrl.toString();
  }

  Future<String> createPostLink({
    String? description,
    String? imageUrl,
    String? username,
    bool? isPost,
    bool? isSubverse,
    bool? isProfile,
    String? postID,
  }) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
        'https://holyvible.com/?isPost=$isPost&isSubverse=$isSubverse&isProfile=$isProfile&username=$username&desc=$description&imageUrl=$imageUrl&username=$username&identifier=$postID',
      ),
      uriPrefix: 'https://holyvible.page.link',
      socialMetaTagParameters: SocialMetaTagParameters(
        title: '$username on Vible',
        description: description,
        imageUrl: Uri.parse(imageUrl ?? ''),
      ),
      androidParameters: const AndroidParameters(
        packageName: 'com.subverse.vible',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.subverse.vible',
        appStoreId: '6444683138',
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    log(dynamicLink.shortUrl.toString());
    return dynamicLink.shortUrl.toString();
  }

  Future<void> retrieveDynamicLink(BuildContext context) async {
    final home = Provider.of<HomeProvider>(context, listen: false);
    final user = Provider.of<UserProfileProvider>(context, listen: false);
    try {
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        log(dynamicLinkData.link.path);
        final Uri deepLink = dynamicLinkData.link;
        String? id = deepLink.queryParameters['id'];
        String? title = deepLink.queryParameters['title'];
        String? desc = deepLink.queryParameters['desc'];
        String? imageUrl = deepLink.queryParameters['imageUrl'];
        String? count = deepLink.queryParameters['count'];
        String? isPost = deepLink.queryParameters['isPost'];
        String? isSubverse = deepLink.queryParameters['isSubverse'];
        String? isProfile = deepLink.queryParameters['isProfile'];
        String? username = deepLink.queryParameters['username'];
        String? identifier = deepLink.queryParameters['identifier'];
        // log('identifier: $identifier');
        if (isSubverse == 'true') {
          // int cat_id = int.parse(id!);
          // int cat_count = int.parse(count!);
          // home.browseSubverseDetail(
          //   context: context,
          //   category_id: cat_id,
          //   category_count: cat_count,
          //   category_desc: desc,
          //   category_name: title,
          //   category_photo: imageUrl,
          // );
        } else if (isProfile == 'true') {
          // await Future.delayed(const Duration(milliseconds: 1000));
          user.posts.clear();
          user.page = 1;
          if (home.isPlaying == true) {
            await home.videoController(home.index)?.pause();
          }
          Navigator.of(context).pushNamed(
            UserProfileScreen.routeName,
            arguments: UserProfileScreenArgs(
              username: username!,
            ),
          );
        } else if (isPost == 'true') {
          // home.single_post.clear();
          // int post_id = int.parse(identifier!);
          // await home.getSinglePost(id: post_id);
          // if (home.isPlaying == true) {
          //   await home.videoController(home.index)?.pause();
          // }
          // Navigator.pushNamed(
          //   context,
          //   VideoWidget.routeName,
          //   arguments: VideoWidgetArgs(
          //     posts: home.single_post,
          //     pageController: PageController(initialPage: 0),
          //     pageIndex: 0,
          //   ),
          // );
        }
      }).onError((error) {
        // Handle errors
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
