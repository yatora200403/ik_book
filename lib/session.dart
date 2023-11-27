import 'package:shared_preferences/shared_preferences.dart';

Future<void> startSession(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
}

Future<bool> isLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username') != null;
}

Future<String?> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username');
}

Future<void> endSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
