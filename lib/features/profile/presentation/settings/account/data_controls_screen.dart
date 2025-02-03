import 'package:socialverse/export.dart';

class DataControlsScreen extends StatelessWidget {
  static const String routeName = '/data-controls';
  const DataControlsScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => DataControlsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<BottomNavBarProvider>(context);
    final account = Provider.of<AccountProvider>(context);
    final profile = Provider.of<ProfileProvider>(context);
    return Consumer<SettingsProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: account.loading ? shrink : null,
            title: Text(
              'Delete Account',
              style: AppTextStyle.normalBold24
                  .copyWith(color: Theme.of(context).focusColor),
              textAlign: TextAlign.start,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height10,
                    RichText(
                      text: TextSpan(
                        style: AppTextStyle.normalBold18
                            .copyWith(color: Theme.of(context).focusColor),
                        children: [
                          TextSpan(
                              text:
                                  'Are you sure you want  to delete your account '),
                          TextSpan(
                            text: profile.user.username,
                            style: TextStyle(color: Colors.red),
                          ),
                          TextSpan(text: ' ?'),
                        ],
                      ),
                    ),
                    height20,
                    Text(
                      'If you choose to delete your account:',
                      style: AppTextStyle.normalRegular14.copyWith(
                          color: Theme.of(context).focusColor.withOpacity(0.8)),
                    ),
                    height15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: AppTextStyle.normalRegular14.copyWith(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.8)),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            'You will no longer be able to log in or access any Wemotions services associated with that account.',
                            style: AppTextStyle.normalRegular14.copyWith(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.8)),
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    height15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: AppTextStyle.normalRegular14.copyWith(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.8)),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            'You will permanently lose access to all your posts, liked posts, followers/following and all other account information.',
                            style: AppTextStyle.normalRegular14.copyWith(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.8)),
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    height15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: AppTextStyle.normalRegular14.copyWith(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.8)),
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            'Doing so will remove your data and close the app.',
                            style: AppTextStyle.normalRegular14.copyWith(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.8)),
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    height15,
                    Text(
                      'Do you wish to proceed?',
                      style: AppTextStyle.normalRegular14.copyWith(
                          color: Theme.of(context).focusColor.withOpacity(0.8)),
                    ),

                  ],
                ),
                account.loading?Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CustomProgressIndicator(),
                        ),
                      ):
                AuthButtonWithColor(
                    title: 'Continue',
                    onTap: () async {
                      // __.deleteAccount(context);
                      HapticFeedback.heavyImpact();
                      nav.currentPage = 0;
                      nav.jumpToPage();
                      await account.logout(context);
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    isGradient: true)
              ],
            ),
          ),
        );
      },
    );
  }
}
