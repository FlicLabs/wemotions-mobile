import 'package:socialverse/export.dart';

class VerifyScreen extends StatelessWidget {
  static const String routeName = '/verify';
  const VerifyScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => VerifyScreen(),
    );
  }

  Future<void> _launchEmailApp() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',  // Just the mailto scheme with no path or query
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email app';
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final notification = getIt<NotificationProvider>();
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.only(right: 20,left: 5),
              child: AppBar(
                toolbarHeight: 80,
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,size: 24,),
                ),
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              height: cs().height(context),
              width: cs().width(context),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(left: 24, right: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Verify Your Account',
                                    style: AppTextStyle.normalSemiBold28Black.copyWith(color: Theme.of(context).focusColor),
                                  ),
                                  height8,
                                  Container(
                                    child: Text(
                                      'Please verify your account by clicking the link we sent to your email.',
                                      style: AppTextStyle.subheadlineMedium.copyWith(color: Theme.of(context).primaryColorDark),),
                                  ),
                                  height90,
                                  Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      AppAsset.verifyEmailHero,
                                      height: 204,
                                      width: 204,
                                      // color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  // height20,
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(left: 24,right: 24,top: 32,bottom: 32),
                          child: Column(
                            children: [
                              if (__.registeredAuthStatus ==
                                  AuthStatus.Registering) ...[
                                SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: CustomProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                              if (__.registeredAuthStatus !=
                                  AuthStatus.Registering) ...[
                                AuthButtonWithColor(
                                  isGradient: true,
                                  onTap: (){
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    _launchEmailApp();
                                  },
                                  title: 'Open Email app',
                                ),
                              ],
                            ],
                          ),)

                      ],
                    ),
                    // Positioned(
                    //   top: Platform.isAndroid ? 5 : 0,
                    //   left: 15,
                    //   child: SafeArea(
                    //     child: CustomIconButton(
                    //       icon: Icons.arrow_back_ios_new_rounded,
                    //       borderRadius: 12,
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
