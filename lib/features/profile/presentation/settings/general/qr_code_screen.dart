import 'package:socialverse/export.dart';

class QrCodeScreenArgs {
  final String name;
  final String username;

  const QrCodeScreenArgs({
    required this.name,
    required this.username,
  });
}

class QrCodeScreen extends StatelessWidget {
  static const String routeName = '/qr-code';
  final String username;
  final String name;
  const QrCodeScreen({super.key, required this.username, required this.name});

  static Route route({required QrCodeScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => QrCodeScreen(
        name: args.name,
        username: args.username,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QrCodeProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          backgroundColor: Theme.of(context).hintColor,
          body: Stack(children: [
            Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 115, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Screenshot(
                          controller: __.screenshotController,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            height: 350,
                            width: cs.width(context) - 70,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$username",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  height10,
                                  QrImageView(
                                    data: '1234567890',
                                    version: QrVersions.auto,
                                    size: 200.0,
                                    gapless: false,
                                    foregroundColor:
                                        Theme.of(context).hintColor,
                                    errorStateBuilder: (context, error) {
                                      __.qrError = true;
                                      return Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                      );
                                    },
                                    embeddedImage: AssetImage(AppAsset.icon),
                                    embeddedImageStyle: QrEmbeddedImageStyle(
                                      size: Size(120, 120),
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  height10,
                                  Text(
                                    'Share your QR so others can follow you',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  height10,
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      AppAsset.icon,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(
                    // bottom: 20,
                    // left: 20,
                    // right: 20,
                    top: 20,
                  ),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Share to',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context).shadowColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        height10,
                        height10,
                        Container(
                          height: 80,
                          width: cs.width(context),
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // MoreItems(
                                  //   icon: Icons.download_outlined,
                                  //   name: 'Save',
                                  //   tap: __.qrError == true
                                  //       ? __.floatingScaffold(
                                  //           context,
                                  //           message:
                                  //               'Uh oh! Something went wrong...Please try again later.',
                                  //         )
                                  //       : () {
                                  //           HapticFeedback.mediumImpact();
                                  //           __.screenshotController
                                  //               .capture(
                                  //             delay: Duration(milliseconds: 10),
                                  //           )
                                  //               .then((capturedImage) async {
                                  //             __.saved(capturedImage!);
                                  //             __.floatingScaffold(
                                  //               context,
                                  //               message:
                                  //                   'Image saved on device',
                                  //             );
                                  //           }).catchError((onError) {
                                  //             print(onError);
                                  //           });
                                  //         },
                                  // ),
                                  height5,
                                  Divider(color: Colors.grey, thickness: 0.1),
                                  // MoreItems(
                                  //   icon: Icons.share_rounded,
                                  //   name: 'Share',
                                  //   tap: __.qrError == true
                                  //       ? __.floatingScaffold(
                                  //           context,
                                  //           message:
                                  //               'Uh oh! Something went wrong...Please try again later.',
                                  //         )
                                  //       : () {
                                  //           HapticFeedback.mediumImpact();
                                  //           __.screenshotController
                                  //               .capture(
                                  //                   delay: Duration(
                                  //                       milliseconds: 10))
                                  //               .then(
                                  //             (Uint8List? value) async {
                                  //               var dir;
                                  //               if (Platform.isAndroid) {
                                  //                 dir =
                                  //                     await getApplicationDocumentsDirectory();
                                  //               } else {
                                  //                 dir =
                                  //                     await getApplicationDocumentsDirectory();
                                  //               }
                                  //               File file = File(
                                  //                 '${dir.path}/${username}.png',
                                  //               );
                                  //               await file.writeAsBytes(value!);
                                  //               Share.shareFiles([
                                  //                 file.path,
                                  //               ], text: 'SocialVerse QR Code');
                                  //               print(
                                  //                 "File Saved to App Documentary",
                                  //               );
                                  //             },
                                  //           );
                                  //         },
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.white,
                      )),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, QRScanner.routeName);
                        },
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            AppAsset.icfliccode,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ]),
        );
      },
    );
  }
}
