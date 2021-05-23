import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {

  SharedPrefManager._privateConstructor();

  static final SharedPrefManager _instance =
      SharedPrefManager._privateConstructor();

  static SharedPrefManager get instance {
    return _instance;
  }
  SharedPreferences _manager;

  //Save to shared pref.
  Future<bool> saveToPref({String key, String value}) async {
    if (_manager == null) {
      _manager = await SharedPreferences.getInstance();
    }
    return _manager.setString(key, value);
  }

  //Get shared pref values
  Future<String> getPrefValues({String key}) async {
    if (_manager == null) {
      _manager = await SharedPreferences.getInstance();
    }
    return _manager.getString(key);
  }

  //Shared Pref clear the key
  Future<bool> clearPref({String key}) async {
    if (_manager == null) {
      _manager = await SharedPreferences.getInstance();
    }
    return _manager.remove(key);
  }

}
