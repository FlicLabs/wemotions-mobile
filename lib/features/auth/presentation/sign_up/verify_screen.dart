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

  Future<void> _launchEmailApp(BuildContext context) async {
    final Uri emailUri = Uri(scheme: 'mailto');

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No email app found. Please open your email manually.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notification = getIt<NotificationProvider>();
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppBar(
                toolbarHeight: 80,
                centerTitle: true,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, size: 24),
                ),
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: () async => false,
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Verify Your Account',
                                style: AppTextStyle.normalSemiBold28Black.copyWith(
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                              height8,
                              Text(
                                'Please verify your account by clicking the link we sent to your email.',
                                style: AppTextStyle.subheadlineMedium.copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              height90,
                              Center(
                                child: SvgPicture.asset(
                                  AppAsset.verifyEmailHero,
                                  height: 204,
                                  width: 204,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        child: Column(
                          children: [
                            if (__.registeredAuthStatus == AuthStatus.Registering) ...[
                              SizedBox(
                                height: 45,
                                width: 45,
                                child: CustomProgressIndicator(color: Colors.white),
                              ),
                            ],
                            if (__.registeredAuthStatus != AuthStatus.Registering) ...[
                              AuthButtonWithColor(
                                isGradient: true,
                                onTap: () {
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                  _launchEmailApp(context);
                                },
                                title: 'Open Email app',
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
