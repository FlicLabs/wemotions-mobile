import 'package:socialverse/export.dart';

class AuthObscureIcon extends StatelessWidget {
  const AuthObscureIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        return __.obscureText
            ? Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  AppAsset.eyeOpen,
                  height: 17,
                  width: 17,
                  color: Theme.of(context).indicatorColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  AppAsset.eyeoff,
                  height: 23,
                  width: 23,
                  color: Theme.of(context).indicatorColor,
                ),
              );
      },
    );
  }
}
