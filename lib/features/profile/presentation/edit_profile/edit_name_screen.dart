// import 'package:socialverse/export.dart';
//
// class EditNameScreenArgs {
//   final String firstname;
//   final String surname;
//
//   const EditNameScreenArgs({
//     required this.firstname,
//     required this.surname,
//   });
// }
//
// class EditNameScreen extends StatelessWidget {
//   static const String routeName = '/edit-name';
//   const EditNameScreen({
//     Key? key,
//     required this.firstname,
//     required this.surname,
//   }) : super(key: key);
//
//   final String firstname;
//   final String surname;
//
//   static Route route({required EditNameScreenArgs args}) {
//     return PageRouteBuilder(
//       settings: const RouteSettings(name: routeName),
//       pageBuilder: (_, __, ___) {
//         return EditNameScreen(
//           firstname: args.firstname,
//           surname: args.surname,
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<EditProfileProvider>(
//       builder: (_, __, ___) {
//         String name = firstname + ' ' + surname;
//         String updateName =
//             __.firstname.text.trim() + ' ' + __.surname.text.trim();
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'Name',
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
//                     __.name.text = updateName;
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
//                 children: [
//                   ProfileAlignedText(
//                     title: 'First Name',
//                   ),
//                   height5,
//                   ProfileTextFormField(
//                     controller: __.firstname,
//                     hintText: 'First Name',
//                     readOnly: false,
//                     enabled: true,
//                     autofocus: true,
//                     onChanged: (val) {
//                       updateName = val.trim() + ' ' + __.surname.text.trim();
//                       if (name == updateName) {
//                         __.edited = false;
//                       } else {
//                         __.edited = true;
//                       }
//                     },
//                   ),
//                   height20,
//                   ProfileAlignedText(
//                     title: 'Last Name',
//                   ),
//                   height5,
//                   ProfileTextFormField(
//                     controller: __.surname,
//                     hintText: 'Last Name',
//                     readOnly: false,
//                     enabled: true,
//                     onChanged: (val) {
//                       updateName = __.firstname.text.trim() + ' ' + val.trim();
//                       if (name == updateName) {
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
