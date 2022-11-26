import "dart:core";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  // Write the data to the SharedPreferences.
  print(writeDataToSharedPreferences("counter", "1"));
  // Get the shared preferences data.
  final int? counter = readDataFromSharedPreferences("counter");
  print(counter);
}

// Read the data from shared preferences
Future<dynamic> readDataFromSharedPreferences(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}

// Write the data to shared preferences
Future<bool> writeDataToSharedPreferences(String key, dynamic value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.set(key, value);
}
