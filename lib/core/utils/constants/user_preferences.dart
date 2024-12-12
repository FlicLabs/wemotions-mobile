import 'package:socialverse/features/auth/domain/models/user.dart';
import 'package:socialverse/main.dart';

class UserPreferences {
  Future<dynamic> saveUser({
    required balance,
    required username,
    required email,
    required first_name,
    required last_name,
    required token,
    required grid_view,
    required logged_in,
    required profile_picture,
    // required gc_member,
  }) async {
    prefs!.setInt("balance", balance);
    prefs!.setString("username", username);
    prefs!.setString("email", email);
    prefs!.setString("first_name", first_name);
    prefs!.setString("last_name", last_name);
    prefs!.setString("token", token);
    prefs!.setBool("grid_view", grid_view);
    prefs!.setBool("logged_in", logged_in);
    prefs!.setString("profile_picture", profile_picture);
    return;
  }

  Future<void> saveWallet({
    required String id,
    required String createdAt,
    required String network,
    required String name,
    required String address,
    required bool wallet_created,
  }) async {
    prefs!.setString("id", id);
    prefs!.setString("createdAt", createdAt);
    prefs!.setString("network", network);
    prefs!.setString("address", address);
    prefs!.setBool("wallet_created", wallet_created);
    return;
  }

  Future<dynamic> saveUploadToken({
    required url,
    required hash,
  }) async {
    prefs!.setString("url", url);
    prefs!.setString("hash", hash);

    return;
  }

  Future<User> getUser() async {
    int balance = prefs!.getInt("balance")!;
    String token = prefs!.getString("token")!;
    String status = prefs!.getString("status")!;
    String username = prefs!.getString("username")!;
    String email = prefs!.getString("email")!;
    String firstName = prefs!.getString("firstName")!;
    String lastName = prefs!.getString("lastName")!;
    // String profilePictureUrl = prefs.getString("profilePictureUrl")!;

    return User(
      balance: balance,
      token: token,
      status: status,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      // profilePictureUrl: profilePictureUrl,
    );
  }

  void removeUser() async {
    prefs!.remove("balance");
    prefs!.remove("token");
    prefs!.remove("status");
    prefs!.remove("username");
    prefs!.remove("email");
    prefs!.remove("firstName");
    prefs!.remove("lastName");
    prefs!.remove("profilePictureUrl");
    prefs!.remove("logged_in");
  }

  void removeWallet() async {
    prefs!.remove("id");
    prefs!.remove("createdAt");
    prefs!.remove("network");
    prefs!.remove("name");
    prefs!.remove("address");
    prefs!.remove("pincode");
  }

  Future<String> getToken(args) async {
    String token = prefs!.getString("token")!;
    return token;
  }
}
