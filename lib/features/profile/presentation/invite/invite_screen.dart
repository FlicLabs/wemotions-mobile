import 'package:line_icons/line_icons.dart';
import 'package:socialverse/core/utils/constants/constants.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/profile/invite/invite_item.dart';

class InviteScreen extends StatelessWidget {
  static const String routeName = '/invite';
  const InviteScreen({super.key});

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const InviteScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final invite = Provider.of<InviteProvider>(context);
    final notification = Provider.of<NotificationProvider>(context);

    final filteredContacts = invite.contacts
        .where((contact) => contact.displayName?.trim().isNotEmpty ?? false)
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      width20,
                      _buildShareItem(context, 'Email', Theme.of(context).hintColor, UniconsLine.fast_mail, () {
                        HapticFeedback.mediumImpact();
                        launchUrl(Uri(
                          scheme: 'mailto',
                          queryParameters: {'body': invite_text + invite.link},
                        ));
                      }),
                      width20,
                      _buildShareItem(context, 'SMS', Colors.green, UniconsLine.comment_message, () {
                        HapticFeedback.mediumImpact();
                        Uri sms = Uri(
                          scheme: 'sms',
                          queryParameters: {'body': invite_text + invite.link},
                        );
                        launchUrl(Uri.parse(sms.toString().replaceAll('+', '%20')));
                      }),
                      width20,
                      _buildShareItem(context, 'Copy link', Colors.yellow, UniconsLine.link, () {
                        Clipboard.setData(ClipboardData(text: invite.link)).then((_) {
                          notification.show(title: 'Link copied!', type: NotificationType.local);
                        });
                      }),
                      width20,
                      _buildShareItem(context, 'WhatsApp', Colors.green.shade700, LineIcons.whatSApp, () {
                        HapticFeedback.mediumImpact();
                        launchUrl(Uri.parse(whatsapp_invite + invite.link), mode: LaunchMode.externalNonBrowserApplication);
                      }),
                      width20,
                      _buildShareItem(context, 'Telegram', Colors.blue.shade700, LineIcons.telegram, () {
                        HapticFeedback.mediumImpact();
                        launchUrl(Uri.parse(telegram_1 + invite.link + invite_text), mode: LaunchMode.externalNonBrowserApplication);
                      }),
                      width20,
                      _buildShareItem(context, 'More', Colors.red, LineIcons.verticalEllipsis, () {
                        HapticFeedback.mediumImpact();
                        Share.share(invite_text + invite.link);
                      }),
                      width20,
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                final displayName = contact.displayName ?? '';

                return InviteItem(
                  index: index,
                  imageUrl: 'contact.avatar',
                  telephone: contact.phones?.isNotEmpty == true ? contact.phones![0].value : '',
                  firstName: displayName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareItem(BuildContext context, String label, Color color, IconData icon, VoidCallback onTap) {
    return ShareToItem(
      label: label,
      color: color,
      icon: icon,
      onTap: onTap,
    );
  }
}

