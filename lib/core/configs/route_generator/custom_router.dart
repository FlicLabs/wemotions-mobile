import 'package:socialverse/export.dart';
import 'package:flutter/foundation.dart';

Route<dynamic> getPlatformPageRoute({
  required WidgetBuilder builder,
  String? routeName,
}) {
  return (defaultTargetPlatform == TargetPlatform.iOS)
      ? CupertinoPageRoute(
          builder: builder,
          settings: RouteSettings(name: routeName),
        )
      : MaterialPageRoute(
          builder: builder,
          settings: RouteSettings(name: routeName),
        );
}

class CustomRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Navigating to: ${settings.name}');
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return _buildRoute(const Scaffold(), '/');
      case WelcomeScreen.routeName:
        return WelcomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case VerifyScreen.routeName:
        return VerifyScreen.route();
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
        return BottomNavBar.route();
      case SearchScreen.routeName:
        return SearchScreen.route();
      case CreateSubverseScreen.routeName:
        return CreateSubverseScreen.route();
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      case DataControlsScreen.routeName:
        return DataControlsScreen.route();
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

      // Screens with Arguments
      case CreateUsernameScreen.routeName:
        return CreateUsernameScreen.route(args: args as CreateUsernameScreenArgs);
      case FollowersScreen.routeName:
        return FollowersScreen.route(args: args as FollowersScreenArgs);
      case FollowingScreen.routeName:
        return FollowingScreen.route(args: args as FollowingScreenArgs);
      case EditSubverseScreen.routeName:
        return EditSubverseScreen.route(args: args as EditSubverseScreenArgs);
      case CameraScreen.routeName:
        return CameraScreen.route(args: args as CameraScreenArgs);
      case PostScreen.routeName:
        return PostScreen.route(args: args as PostScreenArgs);
      case VideoWidget.routeName:
        return VideoWidget.route(args: args as VideoWidgetArgs);
      case UserProfileScreen.routeName:
        return UserProfileScreen.route(args: args as UserProfileScreenArgs);
      case EditProfileScreen.routeName:
        return EditProfileScreen.route(args: args as EditProfileScreenArgs);
      case EditNameScreen.routeName:
        return EditNameScreen.route(args: args as EditNameScreenArgs);
      case EditUsernameScreen.routeName:
        return EditUsernameScreen.route(args: args as EditUsernameScreenArgs);
      case EditBioScreen.routeName:
        return EditBioScreen.route(args: args as EditBioScreenArgs);
      case EditLinksScreen.routeName:
        return EditLinksScreen.route(args: args as EditLinksScreenArgs);
      case SubverseDetailScreen.routeName:
        return SubverseDetailScreen.route(args: args as SubverseDetailScreenArgs);
      case SubverseEmptyScreen.routeName:
        return SubverseEmptyScreen.route(args: args as SubverseEmptyScreenArgs);
      case QrCodeScreen.routeName:
        return QrCodeScreen.route(args: args as QrCodeScreenArgs);
      case ChangeUsernameScreen.routeName:
        return ChangeUsernameScreen.route(args: args as ChangeUsernameScreenArgs);

      default:
        return _errorRoute();
    }
  }

  static Route _buildRoute(Widget screen, String routeName) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => screen,
    );
  }

  static Route _errorRoute() {
    return _buildRoute(
      const Scaffold(
        body: Center(
          child: Text('Error: Route not found'),
        ),
      ),
      '/error',
    );
  }
}

