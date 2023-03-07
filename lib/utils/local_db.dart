
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';


void saveData(String key, String value) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String> loadData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  dynamic data = prefs.getString(key);
  return data;
}

void saveToken(String token) async{
  saveData('token', token);
}