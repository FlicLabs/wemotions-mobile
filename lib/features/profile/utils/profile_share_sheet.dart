import 'package:socialverse/export.dart';
import 'package:line_icons/line_icons.dart';

class ProfileShareSheet extends StatelessWidget {
  final String? dynamicLink;
  const ProfileShareSheet({
    Key? key,
    this.dynamicLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notification = Provider.of<NotificationProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, bottom: 20, right: 0),
            child: SizedBox(
              height: 100,
              width: cs.width(context),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileShareItem(
                        label: 'Email',
                        color: Theme.of(context).hintColor,
                        icon: UniconsLine.fast_mail,
                        onTap: () async {
                          HapticFeedback.mediumImpact();
                          launchUrl(
                            Uri(
                              scheme: 'mailto',
                              queryParameters: {
                                'subject': email,
                                'body': dynamicLink,
                              },
                            ),
                          ).then((value) {});
                        },
                      ),
                      width20,
                      ProfileShareItem(
                        label: 'SMS',
                        color: Colors.green,
                        icon: UniconsLine.comment_message,
                        onTap: () async {
                          HapticFeedback.mediumImpact();
                          Uri sms = Uri(
                            scheme: 'sms',
                            queryParameters: {
                              'subject': '',
                              'body': email + dynamicLink!
                            },
                          );
                          launchUrl(
                            Uri.parse(sms.toString().replaceAll('+', '%20')),
                          );
                        },
                      ),
                      width20,
                      ProfileShareItem(
                        label: 'Copy link',
                        color: Colors.yellow,
                        icon: UniconsLine.link,
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: dynamicLink!),
                          ).then((_) {
                            Navigator.pop(context);
                            notification.show(
                              title: 'Link copied!',
                              type: NotificationType.local,
                            );
                          });
                        },
                      ),
                      width20,
                      ProfileShareItem(
                        label: 'WhatsApp',
                        color: Colors.green.shade700,
                        icon: LineIcons.whatSApp,
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          launchUrl(
                            Uri.parse(whatsapp + dynamicLink!),
                            mode: LaunchMode.externalNonBrowserApplication,
                          ).then((value) {});
                        },
                      ),
                      width20,
                      ProfileShareItem(
                        label: 'Telegram',
                        color: Colors.blue.shade700,
                        icon: LineIcons.telegram,
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          launchUrl(
                            Uri.parse(telegram_1 + dynamicLink! + telegram_2),
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
                        },
                      ),
                      width20,
                      ProfileShareItem(
                        label: 'More',
                        color: Colors.red,
                        icon: Icons.more_vert,
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Share.share(dynamicLink!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          height20,
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, bottom: 20, right: 0),
          //   child: SizedBox(
          //     height: 80,
          //     width: cs().width(context),
          //     child: ListView(
          //       shrinkWrap: true,
          //       scrollDirection: Axis.horizontal,
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             ShareToItem(
          //               label: 'Report',
          //               color: Colors.grey.shade100,
          //               icon: Icons.email_outlined,
          //               onTap: () {},
          //             ),
          //             width20,
          //             ShareToItem(
          //               label: 'Save Video',
          //               color: Colors.grey.shade100,
          //               icon: Icons.download,
          //               onTap: onSaveVideoTap,
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
