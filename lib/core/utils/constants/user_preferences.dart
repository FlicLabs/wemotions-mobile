import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialverse/features/auth/domain/models/user.dart';

class UserPreferences {
  static SharedPreferences? prefs;

  /// Initializes SharedPreferences (must be called before using `UserPreferences`)
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// Save user details to local storage
  Future<void> saveUser({
    required int balance,
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String token,
    required bool gridView,
    required bool loggedIn,
    required String profilePicture,
  }) async {
    await prefs?.setInt("balance", balance);
    await prefs?.setString("username", username);
    await prefs?.setString("email", email);
    await prefs?.setString("first_name", firstName);
    await prefs?.setString("last_name", lastName);
    await prefs?.setString("token", token);
    await prefs?.setBool("grid_view", gridView);
    await prefs?.setBool("logged_in", loggedIn);
    await prefs?.setString("profile_picture", profilePicture);
  }

  /// Save wallet details
  Future<void> saveWallet({
    required String id,
    required String createdAt,
    required String network,
    required String name,
    required String address,
    required bool walletCreated,
  }) async {
    await prefs?.setString("id", id);
    await prefs?.setString("createdAt", createdAt);
    await prefs?.setString("network", network);
    await prefs?.setString("address", address);
    await prefs?.setBool("wallet_created", walletCreated);
  }

  /// Save upload token
  Future<void> saveUploadToken({
    required String url,
    required String hash,
  }) async {
    await prefs?.setString("url", url);
    await prefs?.setString("hash", hash);
  }

  /// Retrieve user data
  Future<User?> getUser() async {
    if (prefs == null) return null;

    return User(
      balance: prefs?.getInt("balance") ?? 0,
      token: prefs?.getString("token") ?? "",
      status: prefs?.getString("status") ?? "",
      username: prefs?.getString("username") ?? "",
      email: prefs?.getString("email") ?? "",
      firstName: prefs?.getString("first_name") ?? "",
      lastName: prefs?.getString("last_name") ?? "",
    );
  }

  /// Remove user data
  Future<void> removeUser() async {
    await prefs?.remove("balance");
    await prefs?.remove("token");
    await prefs?.remove("status");
    await prefs?.remove("username");
    await prefs?.remove("email");
    await prefs?.remove("first_name");
    await prefs?.remove("last_name");
    await prefs?.remove("profile_picture");
    await prefs?.remove("logged_in");
  }

  /// Remove wallet data
  Future<void> removeWallet() async {
    await prefs?.remove("id");
    await prefs?.remove("createdAt");
    await prefs?.remove("network");
    await prefs?.remove("name");
    await prefs?.remove("address");
    await prefs?.remove("wallet_created");
  }

  /// Get token
  Future<String> getToken() async {
    return prefs?.getString("token") ?? "";
  }
}
