import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthController {

  // Log in the user
  Future<ParseUser?> logIn(String username, String password) async {
    print('logIn called');
    var user = ParseUser(username, password, null);
    var response = await user.login();

    if (response.success) {
      print('logIn success');
      return user;
    } else {
      print('logIn failed');
      throw Exception('Failed to log in');
    }
  }

  // Sign up the user
  Future<ParseUser?> signUp(String username, String password, String email) async {
    var user = ParseUser(username, password, email);
    var response = await user.signUp();

    if (response.success) {
      return user;
    } else {
      throw Exception('Failed to sign up');
    }
  }

  // Log out the user
  Future<void> logOut() async {
    try {
      // Wait for the current user to be retrieved
      final currentUser = await ParseUser.currentUser();

      // Check if the current user is not null before calling logOut
      if (currentUser != null) {
        await currentUser.logOut(); // Now you can call logOut() on the currentUser
      } else {
        throw Exception('No user is currently logged in');
      }
    } catch (e) {
      throw Exception('Failed to log out: $e');
    }
  }

  // Get current user
  Future<ParseUser?> getCurrentUser() async {
    return await ParseUser.currentUser();
  }
}
