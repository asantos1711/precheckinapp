import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/configuracion_model.dart';
export 'package:precheckin/models/configuracion_model.dart';

class ConfiguracionProvider{
  Configuracion _config;
  final String _usr = 'apphotel';
  final String _psw = 'hotel25012018';


  static final ConfiguracionProvider _instancia = new ConfiguracionProvider._();

  factory ConfiguracionProvider(){
    return  _instancia;
  }

  ConfiguracionProvider._();

  initData() async {
    _config = await _getConfiguracion();
  }


  ///Consulta al servicio del PMS para obtener
  ///la lista de los parámetros de configuaracion
  /// a utilizar  en la aplicación.
  Future<Configuracion> _getConfiguracion() async {
    Configuracion configuracion;
    String url           = 'http://apihtl.sunset.com.mx:9085/GroupSunsetPMSProxyServices/app/getOneConfigAppPrecheckin';
    String authorization = 'Basic '+base64Encode(utf8.encode('$_usr:$_psw'));

    Map<String, String> headers = {
      "Content-Type"  : "application/x-www-form-urlencoded; charset=utf-8",
      "Accept"        : "application/json",
      "Authorization" : authorization
    };

    Map<String, String> body = {
      'nohotel': "0"
    };

    try {
      final response    = await http.post(url, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      configuracion     = Configuracion.fromJson(decodedData);
    } catch (e) {
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
    }

    return configuracion;
  }

  ///Retorna la instancia de la clase [Configuracion]
  Configuracion get configuracion {
    return _config ?? null;
  }
}