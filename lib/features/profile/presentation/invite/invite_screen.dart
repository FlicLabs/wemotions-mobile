import 'package:line_icons/line_icons.dart';
import 'package:socialverse/export.dart';

class InviteScreen extends StatelessWidget {
  static const String routeName = '/invite';
  const InviteScreen({super.key});

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => InviteScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final invite = Provider.of<InviteProvider>(context);
    final notification = Provider.of<NotificationProvider>(context);

    final filteredContacts = invite.contacts
        .where((contact) =>
            contact.displayName != null &&
            contact.displayName!.trim().isNotEmpty)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invite Friends',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.start,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: cs.width(context),
              height: 100,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
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
                                '': '',
                                'body': invite_text + invite.link,
                              },
                            ),
                          );
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
                              '': '',
                              'body': invite_text + invite.link
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
                            ClipboardData(text: invite.link),
                          ).then((_) {
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
                            Uri.parse(whatsapp_invite + invite.link),
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
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
                            Uri.parse(telegram_1 + invite.link + invite_text),
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
                        },
                      ),
                      width20,
                      ShareToItem(
                        label: 'More',
                        color: Colors.red,
                        icon: LineIcons.verticalEllipsis,
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Share.share(invite_text + invite.link);
                        },
                      ),
                      width20,
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 40,
              ),
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                final displayName = contact.displayName ?? '';

                print('First Name: $displayName');

                return InviteItem(
                  index: index,
                  imageUrl: 'contact.avatar',
                  telephone: contact.phones!.isNotEmpty
                      ? contact.phones![0].value
                      : '',
                  firstName: displayName,
                  // lastName: lastName,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
