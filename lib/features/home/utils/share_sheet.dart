import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icons.dart';
import 'package:socialverse/export.dart';

class ShareSheet extends StatelessWidget {
  final bool? isFromVideoPlayer;
  final String? dynamicLink;
  const ShareSheet({
    Key? key,
    this.isFromVideoPlayer,
    this.dynamicLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final notification = Provider.of<NotificationProvider>(context);
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
        height: cs.height(context)/2.45,
        width: cs.width(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          
                  Expanded(
                    child: Center(
                        child: Text(
                      'Share on',
                      style: AppTextStyle.headlineMedium,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        AppAsset.icClose,
                        fit: BoxFit.scaleDown,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  ),
                ],
              ),
              height32,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
              ),
              height32,
              Divider(color:Constants.tabBarGrey,),
              height24,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Theme.of(context).cardColor,
                    foregroundColor: Constants.darkPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Copy link",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Expanded(
                          child: SizedBox(
                        width: 5,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          UniconsLine.link,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              height24,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Theme.of(context).cardColor,
                    foregroundColor: Constants.darkPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Download",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Expanded(
                          child: SizedBox(
                            width: 5,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgPicture.asset(
                          AppAsset.directDownload,
                          fit: BoxFit.scaleDown,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
