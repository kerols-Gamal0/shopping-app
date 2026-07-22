import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final SharedPreferences _sharedPreferences;
  SharedPref({required this._sharedPreferences});
  Future<void> saveFirstTime() async {
    await _sharedPreferences.setBool('firstTime', false);
  }

  Future<bool> isFirstTime() async {
    return await _sharedPreferences.getBool('firstTime') ?? true;
  }
}
