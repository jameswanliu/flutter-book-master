import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  Preference._();


  static Preference _instance;

  static Preference getInstance() {
    if (_instance == null) {
      _instance = Preference._();
    }
    return _instance;
  }

   setInt(String key, int value) async{
     SharedPreferences preferences =  await SharedPreferences.getInstance();
     return preferences.setInt(key,value);
  }

  setString(String key, String value) async{
    SharedPreferences preferences =  await SharedPreferences.getInstance();
    return preferences.setString(key,value);
  }

   getInt(String key) async{
     SharedPreferences preferences =  await SharedPreferences.getInstance();
     return preferences.getInt(key);
  }

   Future<String> getString(String key) async{
    SharedPreferences preferences =  await SharedPreferences.getInstance();
    return await preferences.getString(key);
  }
}
