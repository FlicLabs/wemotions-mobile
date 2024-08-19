// import 'package:empowerverse/export.dart';

// class ProfileBody extends StatelessWidget {
//   const ProfileBody({
//     super.key,
//     required this.controller,
//     required this.username,
//     required this.isFollowing,
//     required this.mainUser,
//     required this.userFollowingCount,
//     required this.tempFollowingCount,
//     required this.userFollowerCount,
//     required this.tempFollowerCount,
//     required this.userProfilePicture,
//     required this.tempProfilePicture,
//     required this.likedPosts,
//     required this.posts,
//     required this.tempPosts,
//     required this.userPostCount,
//     required this.tempPostCount,
//     required this.name,
//     required this.temp_name,
//     this.isBlocked = false,
//   });

//   final ScrollController controller;
//   final String username;
//   final String name;
//   final String temp_name;
//   final Function(bool isFollow)? isFollowing;
//   final bool mainUser;
//   final bool isBlocked;

//   final int userFollowingCount;
//   final int tempFollowingCount;

//   final int userFollowerCount;
//   final int tempFollowerCount;

//   final int userPostCount;
//   final int tempPostCount;

//   final String userProfilePicture;
//   final String tempProfilePicture;

//   final List<UserPostModel> likedPosts;
//   final List<UserPostModel> posts;
//   final List<UserPostModel> tempPosts;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserProfileProvider>(
//       builder: (_, __, ___) {
//         return Scaffold(
//           appBar: AppBar(
//             leading: mainUser == true ? shrink : null,
//             leadingWidth: mainUser == true ? 10 : null,
//             centerTitle: mainUser == true ? false : true,
//             title: Text(
//               mainUser == true ? __.user.username : __.user.username,
//               style: Theme.of(context).textTheme.bodyLarge,
//               textAlign: TextAlign.start,
//             ),
//             // actions: [ProfileHeader(mainUser: mainUser)],
//           ),
//           body: RefreshIndicator(
//             color: Theme.of(context).indicatorColor,
//             backgroundColor: Theme.of(context).primaryColor,
//             onRefresh: () async {
//               // if (prefs_username == username) {
//               //   __.posts.clear();
//               //   __.page = 1;
//               //   __.getUserProfile(username: username, fromUser: true);
//               // } else {
//               //   __.temp_user_posts.clear();
//               //   __.temp_page = 1;
//               //   __.getUserProfile(username: username, fromUser: false);
//               // }
//             },
//             child: SingleChildScrollView(
//               controller: controller,
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Stack(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       if (__.isBlocked) ...[
//                         Center(
//                           child: CustomCircularAvatar(
//                             borderColor: Theme.of(context).hintColor,
//                             height: 100,
//                             width: 100,
//                             imageUrl: prefs_username == username
//                                 ? userProfilePicture
//                                 : tempProfilePicture,
//                           ),
//                         ),
//                         height10,
//                         Text(
//                           username == prefs_username ? name : temp_name,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyLarge!
//                               .copyWith(fontSize: 20),
//                         ),
//                         height10,
//                         // ProfileButton(
//                         //   username: username,
//                         //   mainUser: prefs_username == username,
//                         //   isFollowing: isFollowing,
//                         // ),
//                         height10,
//                         Padding(
//                           padding: const EdgeInsets.only(left: 40, right: 40),
//                           child: Text(
//                             '${__.user.username} is currently blocked, unblock them to be able to view their posts',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displaySmall!
//                                 .copyWith(fontSize: 14),
//                             textAlign: TextAlign.center,
//                           ),
//                         )
//                       ],
//                       if (!__.isBlocked) ...[
//                         if (userProfilePicture.isNotEmpty ||
//                             tempProfilePicture.isNotEmpty) ...[
//                           CustomCircularAvatar(
//                             borderColor: Theme.of(context).hintColor,
//                             height: 100,
//                             width: 100,
//                             imageUrl: prefs_username == username
//                                 ? userProfilePicture
//                                 : tempProfilePicture,
//                           ),
//                         ],
//                         height10,
//                         Column(
//                           children: [
//                             Text(
//                               username == prefs_username ? name : temp_name,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge!
//                                   .copyWith(fontSize: 20),
//                             ),
//                             height10,
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: ProfileStatsItem(
//                                     value: prefs_username == username
//                                         ? userFollowingCount
//                                         : tempFollowingCount,
//                                     label: 'Following',
//                                     onTap: () {
//                                       if (prefs_username == username) {
//                                         if (userFollowingCount != 0) {
//                                           Navigator.of(context).pushNamed(
//                                             FollowingScreen.routeName,
//                                             arguments: FollowingScreenArgs(
//                                               username: username,
//                                             ),
//                                           );
//                                         }
//                                       } else {
//                                         if (tempFollowingCount != 0) {
//                                           Navigator.of(context).pushNamed(
//                                             FollowingScreen.routeName,
//                                             arguments: FollowingScreenArgs(
//                                               username: username,
//                                             ),
//                                           );
//                                         }
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: ProfileStatsItem(
//                                     value: prefs_username == username
//                                         ? userFollowerCount
//                                         : tempFollowerCount,
//                                     label: 'Followers',
//                                     onTap: () {
//                                       if (prefs_username == username) {
//                                         if (userFollowerCount != 0) {
//                                           Navigator.of(context).pushNamed(
//                                             FollowersScreen.routeName,
//                                             arguments: FollowersScreenArgs(
//                                               username: username,
//                                             ),
//                                           );
//                                         }
//                                       } else {
//                                         if (tempFollowerCount != 0) {
//                                           Navigator.of(context).pushNamed(
//                                             FollowersScreen.routeName,
//                                             arguments: FollowersScreenArgs(
//                                               username: username,
//                                             ),
//                                           );
//                                         }
//                                       }
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: ProfileStatsItem(
//                                     value: prefs_username == username
//                                         ? userPostCount
//                                         : tempPostCount,
//                                     label: 'Posts',
//                                     onTap: () {},
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             height10,
//                             // ProfileButton(
//                             //   username: username,
//                             //   mainUser: prefs_username == username,
//                             //   isFollowing: isFollowing,
//                             // ),
//                             // Bio(mainUser: prefs_username == username),
//                             // ProfileInfo(mainUser: prefs_username == username),
//                             height10,
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               child: IntrinsicHeight(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     ProfileTabItem(
//                                       label: prefs_username == username
//                                           ? 'My Posts'
//                                           : 'Posts',
//                                       index: 0,
//                                     ),
//                                     VerticalDivider(
//                                       color: Colors.grey.shade300,
//                                       width: 2,
//                                       thickness: 1,
//                                     ),
//                                     ProfileTabItem(
//                                       username: username,
//                                       label: 'Liked',
//                                       index: 1,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             height20,
//                             if (__.tab == 0) ...[
//                               //TODO: Refactor profile tabs
//                               Padding(
//                                 padding: prefs_username == username
//                                     ? const EdgeInsets.only(bottom: 100)
//                                     : const EdgeInsets.only(bottom: 40),
//                                 child: PostsGrid(
//                                   posts: prefs_username == username
//                                       ? posts
//                                       : tempPosts,
//                                 ),
//                               ),
//                             ],
//                             if (__.tab == 1) ...[
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     bottom: cs().height(context)),
//                                 child: prefs_username == username
//                                     ? PostsGrid(
//                                         posts: likedPosts,
//                                       )
//                                     : Padding(
//                                         padding: EdgeInsets.only(
//                                           top: 50,
//                                         ),
//                                         child: Text(
//                                           'This user\'s liked videos are private',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .displaySmall!
//                                               .copyWith(fontSize: 14),
//                                         ),
//                                       ),
//                               )
//                             ]
//                           ],
//                         ),
//                       ]
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
