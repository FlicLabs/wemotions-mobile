// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:device_apps/device_apps.dart';
// import 'package:share_plus/share_plus.dart';
//
// class ShareOptionsRow extends StatefulWidget {
//   final String shareText;
//
//   const ShareOptionsRow({Key? key, required this.shareText}) : super(key: key);
//
//   @override
//   _ShareOptionsRowState createState() => _ShareOptionsRowState();
// }
//
// class _ShareOptionsRowState extends State<ShareOptionsRow> {
//   List<Application> shareApps = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadApps();
//   }
//
//   void loadApps() async {
//     List<Application> apps = await DeviceApps.getInstalledApplications(
//       onlyAppsWithLaunchIntent: true,
//       includeSystemApps: false,
//     );
//
//     setState(() {
//       shareApps = apps.where((app) {
//         return app.packageName.contains("whatsapp") ||
//             app.packageName.contains("telegram") ||
//             app.packageName.contains("messaging") ||
//             app.packageName.contains("email") ||
//             app.packageName.contains("twitter") ||
//             app.packageName.contains("facebook") ||
//             app.packageName.contains("instagram");
//       }).toList();
//     });
//   }
//
//   void shareViaApp(String packageName) async {
//     HapticFeedback.mediumImpact();
//     await Share.share(
//       widget.shareText,
//       sharePositionOrigin: Rect.fromCenter(
//           center: Offset.zero, width: 1, height: 1),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: shareApps.map((app) {
//           return GestureDetector(
//             onTap: () => shareViaApp(app.packageName),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 28,
//                   backgroundImage: app is ApplicationWithIcon
//                       ? MemoryImage(app.icon)
//                       : null,
//                   backgroundColor: Colors.grey.shade300,
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   app.appName,
//                   style: TextStyle(fontSize: 12),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
