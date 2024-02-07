import 'package:shared_preferences/shared_preferences.dart';

void savePreference({required String key, required String value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

void deletePreference({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

Future<bool> hasPreference({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey(key);
}

Future<String?> getPreference({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

void printSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Set<String> keys = prefs.getKeys();

  keys.forEach((key) {
    dynamic value = prefs.get(key);
    print('$key : $value');
  });
}

Future<void> deleteAllSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys(); // Get all keys

  // Loop through keys and remove them
  for (String key in keys) {
    await prefs.remove(key);
  }
}
