import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences(){
    return _instance;
  }

  UserPreferences._internal();


  SharedPreferences _pref;

  initPref() async {
    _pref = await SharedPreferences.getInstance();

  }

  String get idioma {
    return _pref.getString("idioma");
  }

  set idioma(String idioma){
    _pref.setString("idioma", idioma);
  }



}