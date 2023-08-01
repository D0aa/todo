import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> put({required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setInt(key, value);
    }
  }

  static dynamic get({required String key}){
    return sharedPreferences.get(key);
}

  static Future<bool> removeDate({required key})async{
    return sharedPreferences.remove(key);
}
  static Future<bool> clearDate()async{
    return sharedPreferences.clear();
  }
}
