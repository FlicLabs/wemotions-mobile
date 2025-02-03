// import 'package:socialverse/export.dart';
//
// class EditBioScreenArgs {
//   final String bio;
//
//   const EditBioScreenArgs({required this.bio});
// }
//
// class EditBioScreen extends StatelessWidget {
//   static const String routeName = '/edit-bio';
//   const EditBioScreen({
//     Key? key,
//     required this.bio,
//   }) : super(key: key);
//
//   final String bio;
//
//   static Route route({required EditBioScreenArgs args}) {
//     return CupertinoPageRoute(
//       settings: const RouteSettings(name: routeName),
//       builder: (context) => EditBioScreen(bio: args.bio),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<EditProfileProvider>(
//       builder: (_, __, ___) {
//         String updatedBio = bio;
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'Bio',
//               style: Theme.of(context).textTheme.bodyLarge,
//               textAlign: TextAlign.start,
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   right: 20,
//                   top: 20,
//                 ),
//                 child: SaveButton(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               )
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ProfileAlignedText(
//                     title: 'Bio',
//                   ),
//                   height5,
//                   ProfileTextFormField(
//                     controller: __.bio,
//                     hintText: 'Bio',
//                     maxLines: 2,
//                     enabled: true,
//                     autofocus: true,
//                     maxLength: 130,
//                     onChanged: (val) {
//                       updatedBio = val;
//                       if (bio == updatedBio) {
//                         __.edited = false;
//                       } else {
//                         __.edited = true;
//                       }
//                     },
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
