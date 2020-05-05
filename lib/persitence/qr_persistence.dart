import 'package:shared_preferences/shared_preferences.dart';

class QRPersistence {

  static final QRPersistence _instance = new QRPersistence._internal();

  factory QRPersistence(){
    return _instance;
  }

  QRPersistence._internal();


  SharedPreferences _pref;

  initPref() async {
    _pref = await SharedPreferences.getInstance();

  }

  List<String> get qr {
    return _pref.getStringList("listQR") ?? [];
  }

  set qr(List<String> listQR){
    _pref.setStringList("listQR", listQR);
  }



}