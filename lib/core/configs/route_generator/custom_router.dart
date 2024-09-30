import 'package:socialverse/export.dart';

Route<dynamic> getPlatformPageRoute({
  required WidgetBuilder builder,
  String? routeName,
}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(
      builder: builder,
      settings: RouteSettings(name: routeName),
    );
  } else {
    return MaterialPageRoute(
      builder: builder,
      settings: RouteSettings(name: routeName),
    );
  }
}

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => Scaffold(),
        );
      case WelcomeScreen.routeName:
        return WelcomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case VerifyScreen.routeName:
        return VerifyScreen.route();
      case CreateUsernameScreen.routeName:
        return CreateUsernameScreen.route(
          args: settings.arguments as CreateUsernameScreenArgs,
        );
      case UsernameScreen.routeName:
        return UsernameScreen.route();
      case NameScreen.routeName:
        return NameScreen.route();
      case PasswordScreen.routeName:
        return PasswordScreen.route();
      case EmailScreen.routeName:
        return EmailScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      case BottomNavBar.routeName:
        return BottomNavBar.route(
          args: settings.arguments as BottomNavBarArgs,
        );
      case SearchScreen.routeName:
        return SearchScreen.route();
      case CreateSubverseScreen.routeName:
        return CreateSubverseScreen.route();
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      case DataControlsScreen.routeName:
        return DataControlsScreen.route();
      case FollowersScreen.routeName:
        return FollowersScreen.route(
          args: settings.arguments as FollowersScreenArgs,
        );
      case FollowingScreen.routeName:
        return FollowingScreen.route(
          args: settings.arguments as FollowingScreenArgs,
        );
      case EditSubverseScreen.routeName:
        return EditSubverseScreen.route(
          args: settings.arguments as EditSubverseScreenArgs,
        );
      case CameraScreen.routeName:
        return CameraScreen.route(
          args: settings.arguments as CameraScreenArgs,
        );
      case PostScreen.routeName:
        return PostScreen.route(
          args: settings.arguments as PostScreenArgs,
        );
      case VideoWidget.routeName:
        return VideoWidget.route(
          args: settings.arguments as VideoWidgetArgs,
        );
      case UserProfileScreen.routeName:
        return UserProfileScreen.route(
          args: settings.arguments as UserProfileScreenArgs,
        );
      case EditProfileScreen.routeName:
        return EditProfileScreen.route(
          args: settings.arguments as EditProfileScreenArgs,
        );
      case EditNameScreen.routeName:
        return EditNameScreen.route(
          args: settings.arguments as EditNameScreenArgs,
        );
      case EditUsernameScreen.routeName:
        return EditUsernameScreen.route(
          args: settings.arguments as EditUsernameScreenArgs,
        );
      case EditBioScreen.routeName:
        return EditBioScreen.route(
          args: settings.arguments as EditBioScreenArgs,
        );
      case EditLinksScreen.routeName:
        return EditLinksScreen.route(
          args: settings.arguments as EditLinksScreenArgs,
        );
      case SubverseDetailScreen.routeName:
        return SubverseDetailScreen.route(
          args: settings.arguments as SubverseDetailScreenArgs,
        );
      case SubverseEmptyScreen.routeName:
        return SubverseEmptyScreen.route(
          args: settings.arguments as SubverseEmptyScreenArgs,
        );
      case QrCodeScreen.routeName:
        return QrCodeScreen.route(
          args: settings.arguments as QrCodeScreenArgs,
        );
      case ChangeUsernameScreen.routeName:
        return ChangeUsernameScreen.route(
          args: settings.arguments as ChangeUsernameScreenArgs,
        );
      case QRScanner.routeName:
        return QRScanner.route();
      case ThemeSwitchScreen.routeName:
        return ThemeSwitchScreen.route();
      case ForgotPasswordScreen.routeName:
        return ForgotPasswordScreen.route();
      case InviteScreen.routeName:
        return InviteScreen.route();
      case AddFriendsScreen.routeName:
        return AddFriendsScreen.route();
      case ManageAccountScreen.routeName:
        return ManageAccountScreen.route();
      case AccountInformationScreen.routeName:
        return AccountInformationScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      ),
      // builder: (_) => const ErrorScreen(),
    );
  }
}
