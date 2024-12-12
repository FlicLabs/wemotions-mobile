import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:socialverse/export.dart';
import 'package:dio/dio.dart';
import 'package:socialverse/features/auth/domain/service/auth_service.dart';
import 'dart:math' show Random;
import 'package:crypto/crypto.dart';


enum AuthStatus {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Authenticated,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  final email = TextEditingController();
  final password = TextEditingController();
  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final username = TextEditingController();

  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final usernameFK = GlobalKey<FormState>();
  final passwordFK = GlobalKey<FormState>();
  final nameFK = GlobalKey<FormState>();
  final emailFK = GlobalKey<FormState>();

  final notification = getIt<NotificationProvider>();

  final _service = AuthService();

  AuthStatus _loggedInAuthStatus = AuthStatus.NotLoggedIn;
  AuthStatus _registeredAuthStatus = AuthStatus.NotRegistered;

  AuthStatus get loggedInAuthStatus => _loggedInAuthStatus;

  set loggedInStatus(AuthStatus value) {
    _loggedInAuthStatus = value;
  }

  AuthStatus get registeredAuthStatus => _registeredAuthStatus;

  set registeredAuthStatus(AuthStatus value) {
    _registeredAuthStatus = value;
  }

  String? _lastnameError = null;
  String? get lastnameError => _lastnameError;

  set lastnameError(String? error) {
    _lastnameError = error;
    notifyListeners();
  }

  String? _firstnameError = null;
  String? get firstnameError => _firstnameError;

  set firstnameError(String? error) {
    _firstnameError = error;
    notifyListeners();
  }

  String? _usernameError = null;
  String? get usernameError => _usernameError;

  set usernameError(String? error) {
    _usernameError = error;
    notifyListeners();
  }

  String? _emailError = null;
  String? get emailError => _emailError;

  set emailError(String? error) {
    _emailError = error;
    notifyListeners();
  }

  String? _passwordError = null;
  String? get passwordError => _passwordError;

  set passwordError(String? error) {
    _passwordError = error;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  bool _edited = false;
  bool get edited => _edited;

  set edited(bool value) {
    _edited = value;
    notifyListeners();
  }

  ProfileModel _user = ProfileModel.empty;
  ProfileModel get user => _user;

  bool _checkValue = false;
  bool get checkValue => _checkValue;

  set checkValue(bool value) {
    _checkValue = value;
    notifyListeners();
  }

  bool _incorrectPassword = false;
  bool get incorrectPassword => _incorrectPassword;

  set incorrectPassword(bool value) {
    _incorrectPassword = value;
    notifyListeners();
  }

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    Map data = {
      'mixed': email,
      'password': password,
    };

    _loggedInAuthStatus = AuthStatus.Authenticating;
    notifyListeners();

    Response response = await _service.login(data);

    if (response.statusCode == 200) {
      if (response.data['status'] == 'success') {
        final Map<String, dynamic> responseData = response.data;
        var userData = responseData;
        User authUser = User.fromJson(userData);

        User user = authUser;
        log(user.token.toString());

        await UserPreferences().saveUser(
          balance: user.balance,
          username: user.username,
          email: user.email,
          first_name: user.firstName,
          last_name: user.lastName,
          token: user.token,
          profile_picture: user.profilePictureUrl,
          grid_view: false,
          logged_in: true,
        );

        logged_in = prefs?.getBool('logged_in') ?? false;
        prefs_username = prefs?.getString('username') ?? '';
        token = prefs?.getString('token') ?? '';
        prefs_email = prefs?.getString('email') ?? '';

        _loggedInAuthStatus = AuthStatus.LoggedIn;
        notifyListeners();

        navKey.currentState!
          ..pop()
          ..pop()
          ..pop();

        log('Login Successful');
      } else {
        _loggedInAuthStatus = AuthStatus.NotLoggedIn;
        notifyListeners();
        if (response.data['message'] ==
            'Oh no! Your credentials do not match!') {
          _incorrectPassword = true;
          loginFormKey.currentState!.validate();
        } else {
          notification.show(
            title: response.data['message'],
            type: NotificationType.local,
          );
        }
      }
    } else {
      _loggedInAuthStatus = AuthStatus.NotLoggedIn;
      notifyListeners();
      notification.show(
        title: response.data['message'],
        type: NotificationType.local,
      );
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String email,
  }) async {
    Map data = {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'password': password,
      'email': email,
    };

    _registeredAuthStatus = AuthStatus.Registering;
    notifyListeners();

    Response response = await _service.signUp(data);

    if (response.statusCode == 200) {
      if (response.data['status'] == 'success') {
        _registeredAuthStatus = AuthStatus.Registered;
        notifyListeners();

        navKey.currentState!.pushNamed(VerifyScreen.routeName);

        notification.show(
          title: 'Kindly check your email to verify your account',
          type: NotificationType.local,
        );

        // Registration Successful, Kindly check your email to verify your account and proceed back to login
      } else {
        _registeredAuthStatus = AuthStatus.NotRegistered;
        notifyListeners();

        notification.show(
          title: response.data['message'],
          type: NotificationType.local,
        );
      }
    } else {
      _registeredAuthStatus = AuthStatus.NotRegistered;
      notifyListeners();

      notification.show(
        title: response.data['message'],
        type: NotificationType.local,
      );

      log('Something went wrong');
    }
  }

  Future<void> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = fb.OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // print(oauthCredential.idToken);

    fb.User? user = (await fb.FirebaseAuth.instance.signInWithCredential(
      oauthCredential,
    ))
        .user;

    fb.IdTokenResult authToken = await user!.getIdTokenResult();
    _loggedInAuthStatus = AuthStatus.Authenticating;
    notifyListeners();
    String token = authToken.token.toString();
    log(token);

    Map data = {
      'token': token,
    };

    Response response = await _service.oauth(data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = response.data;
      var userData = responseData;
      User authUser = User.fromJson(userData);

      User user = authUser;
      log('${user.token}');

      await UserPreferences().saveUser(
        balance: user.balance,
        username: user.username,
        email: user.email,
        first_name: user.firstName,
        last_name: user.lastName,
        token: user.token,
        profile_picture: user.profilePictureUrl,
        grid_view: false,
        logged_in: true,
      );

      logged_in = prefs?.getBool('logged_in') ?? false;
      prefs_username = prefs?.getString('username') ?? '';
      token = prefs?.getString('token') ?? '';
      prefs_email = prefs?.getString('email') ?? '';

      _loggedInAuthStatus = AuthStatus.LoggedIn;
      notifyListeners();

      log('valid username');
      log('Login Successful');
      navKey.currentState!
        ..pop()
        ..pop();
    } else {
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ["profile", "email"],).signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    fb.User? user =
        (await fb.FirebaseAuth.instance.signInWithCredential(credential)).user;
    fb.IdTokenResult mytoken = await user!.getIdTokenResult();
    _loggedInAuthStatus = AuthStatus.Authenticating;
    notifyListeners();
    String token = mytoken.token.toString();
    log(token.toString());

    Map data = {
      'token': token,
    };

    Response response = await _service.oauth(data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = response.data;
      var userData = responseData;
      User authUser = User.fromJson(userData);

      User user = authUser;
      log(user.token.toString());

      await UserPreferences().saveUser(
        balance: user.balance,
        username: user.username,
        email: user.email,
        first_name: user.firstName,
        last_name: user.lastName,
        token: user.token,
        profile_picture: user.profilePictureUrl,
        grid_view: false,
        logged_in: true,
      );
    }

    logged_in = prefs?.getBool('logged_in') ?? false;
    prefs_username = prefs?.getString('username') ?? '';
    token = prefs?.getString('token') ?? '';
    prefs_email = prefs?.getString('email') ?? '';

    log(prefs_username.toString());

    username.text = prefs_username!;

    _loggedInAuthStatus = AuthStatus.LoggedIn;
    notifyListeners();

    log('valid username');
    log('Login Successful');
    navKey.currentState!
      ..pop()
      ..pop();
  }

  // Future<int> updateUsername(context) async {
  //   log('init');
  //   _loading = true;
  //   notifyListeners();

  //   Map data = {
  //     "new_username": username.text.trim(),
  //   };

  //   log('updating username');
  //   Response response = await _edit_service.updateUsername(data);

  //   if (response.data['status'] == 'success') {
  //     Response response = await _edit_service.getUsername(
  //       username: username.text.trim(),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       String jsonString = json.encode(response.data);
  //       final Map<String, dynamic> responseData = json.decode(jsonString);
  //       var userData = responseData;
  //       ProfileModel userProfile = ProfileModel.fromJson(userData);
  //       _user = userProfile;
  //       prefs!.setString("username", user.username);
  //       prefs_username = prefs?.getString('username') ?? '';

  //       // log('load user profile');
  //       // getIt<UserProfileProvider>().getUserProfile(
  //       //   context,
  //       //   username: prefs_username!,
  //       //   fromUser: true,
  //       // );

  //       _loading = false;
  //       notifyListeners();

  //       navKey.currentState!
  //         ..pop()
  //         ..pop()
  //         ..pop();
  //     }

  //     getIt<SnackBarProvider>().floatingScaffold(
  //       message: 'Your username has been updated',
  //       height: 80,
  //     );
  //   } else if (response.data['status'] == 'error') {
  //     username.text = '';
  //     _loading = false;
  //     notifyListeners();
  //     getIt<SnackBarProvider>().floatingScaffold(
  //       message: 'Username already exists',
  //       height: 40,
  //     );
  //   } else {
  //     _loading = false;
  //     notifyListeners();
  //     getIt<SnackBarProvider>().floatingScaffold(
  //       message: 'Something went wrong, Please try again',
  //       height: 40,
  //     );
  //   }

  //   return response.statusCode!;
  // }

  Future<void> showAuthBottomSheet(context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (context) {
        return const AuthBottomSheet();
      },
    );
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<dynamic> reset() async {
    HapticFeedback.mediumImpact();
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> data = {
      'mixed': email.text.trim(),
    };

    Response response = await _service.reset(data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      _isLoading = false;

      notification.show(
        title: response.data['message'],
        type: NotificationType.local,
      );

      notifyListeners();
    } else {
      _isLoading = false;

      notification.show(
        title: response.data['message'],
        type: NotificationType.local,
      );

      notifyListeners();
    }
  }
}
