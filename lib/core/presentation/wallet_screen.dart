import 'package:socialverse/export.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: cs().height(context),
        width: cs().width(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAsset.darkThemeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: cs().height(context) * 0.04,
                        ),
                        Text(
                          "Welcome to SocialVerse Wallet",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        height15,
                        Text(
                          "SocialVerse Wallet allows you to deposit crypto assets into your wallet, manage all your assets and send send crypto you your friends",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: cs().height(context) * 0.1),
                          child: SvgPicture.asset(AppAsset.wallet),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: cs().height(context) * 0.15,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextButton(
                    title: 'Wallet is coming soon',
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
