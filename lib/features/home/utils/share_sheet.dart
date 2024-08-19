import 'package:line_icons/line_icons.dart';
import 'package:socialverse/core/utils/constants/constants.dart';
import 'package:socialverse/export.dart';

class ShareSheet extends StatelessWidget {
  final bool isUser;
  final bool? isFromVideoPlayer;
  final String? dynamicLink;
  const ShareSheet({
    Key? key,
    required this.isUser,
    this.isFromVideoPlayer,
    this.dynamicLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notification = Provider.of<NotificationProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 0, bottom: 40, right: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: SizedBox(
        height: 100,
        width: cs().width(context),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                width20,
                ShareToItem(
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
                ShareToItem(
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
                ShareToItem(
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
                ShareToItem(
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
                ShareToItem(
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
                ShareToItem(
                  label: 'More',
                  color: Colors.red,
                  icon: Icons.more_vert,
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Share.share(dynamicLink!);
                  },
                ),
                width20,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
