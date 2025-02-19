// import 'package:socialverse/export.dart';
//
// class SubverseDetailScreenArgs {
//   final String category_name;
//   final String category_desc;
//   final int category_count;
//   final int category_id;
//   final bool fromVideoPlayer;
//   final String category_photo;
//
//   const SubverseDetailScreenArgs({
//     required this.category_name,
//     required this.category_desc,
//     required this.category_count,
//     required this.category_id,
//     required this.fromVideoPlayer,
//     required this.category_photo,
//   });
// }
//
// class SubverseDetailScreen extends StatefulWidget {
//   static const String routeName = '/subverse-detail';
//   const SubverseDetailScreen(
//       {Key? key,
//       required this.category_name,
//       required this.category_desc,
//       required this.category_count,
//       required this.category_id,
//       required this.fromVideoPlayer,
//       required this.category_photo})
//       : super(key: key);
//
//   static Route route({required SubverseDetailScreenArgs args}) {
//     return CupertinoPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (context) => SubverseDetailScreen(
//         category_name: args.category_name,
//         category_desc: args.category_desc,
//         category_count: args.category_count,
//         category_id: args.category_id,
//         fromVideoPlayer: args.fromVideoPlayer,
//         category_photo: args.category_photo,
//       ),
//     );
//   }
//
//   final String category_name;
//   final String category_desc;
//   final int category_count;
//   final int category_id;
//   final bool fromVideoPlayer;
//   final String category_photo;
//
//   @override
//   State<SubverseDetailScreen> createState() => _SubverseDetailScreenState();
// }
//
// class _SubverseDetailScreenState extends State<SubverseDetailScreen> {
//   final controller = ScrollController();
//
//   @override
//   void initState() {
//     controller.addListener(_scrollListener);
//     super.initState();
//   }
//
//   void _scrollListener() {
//     final home = Provider.of<HomeProvider>(context, listen: false);
//     if (mounted) {
//       if (controller.position.pixels == controller.position.maxScrollExtent) {
//         HapticFeedback.mediumImpact();
//         // home.subverse_page++;
//         // home.getSubversePosts(id: subverse_id, page: home.subverse_page);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeProvider home = Provider.of<HomeProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).primaryColor,
//         title: Text(
//           widget.category_name,
//           style: Theme.of(context).textTheme.bodyLarge,
//           textAlign: TextAlign.start,
//         ),
//       ),
//       body: SizedBox(
//         height: cs.height(context),
//         width: cs.width(context),
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               controller: controller,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SubverseDetailHeader(
//                     category_photo: widget.category_photo,
//                     category_name: widget.category_name,
//                     category_desc: widget.category_desc,
//                     category_count: widget.category_count,
//                   ),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     padding: EdgeInsets.only(
//                       top: 20,
//                       bottom: cs.height(context) * 0.04,
//                     ),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 1,
//                       mainAxisSpacing: 1,
//                       childAspectRatio: 0.65,
//                     ),
//                     itemCount: home.subversePosts.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return SubversePostGridItem(
//                         onTap: () {
//                           Navigator.pushNamed(
//                             context,
//                             VideoWidget.routeName,
//                             arguments: VideoWidgetArgs(
//                               isFromSubverse: true,
//                               posts: home.subversePosts,
//                               pageController:
//                                   PageController(initialPage: index),
//                               pageIndex: index,
//                             ),
//                           );
//                         },
//                         imageUrl: home.subversePosts[index].thumbnailUrl,
//                         createdAt: home.subversePosts[index].createdAt,
//                         viewCount: home.subversePosts[index].viewCount,
//                         username: home.subversePosts[index].username,
//                         pictureUrl: home.subversePosts[index].pictureUrl,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
