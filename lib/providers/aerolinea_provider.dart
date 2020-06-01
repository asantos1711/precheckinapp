import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/aerolineas_model.dart';
import 'package:precheckin/models/vuelos_model.dart';
import 'package:precheckin/providers/configuracion_provider.dart';

class AerolineaProvider {
  ConfiguracionProvider _provider;
  Configuracion _config;
  String _usr;
  String _psw;

  AerolineaProvider(){
    _provider = new ConfiguracionProvider();
    _config   = _provider?.configuracion;
    _usr      = _config?.usrServices;
    _psw      = _config?.pswServices;
  }




  ///Consulta al servicio getListaAerolineas
  ///para obtener la lista de las aerolineas  disponibles.
  Future<AerolineasModel> getAerolineas() async {
    AerolineasModel aeroLineas;
    String url = _config?.getAirlinesServiceUrl;
    
    Map<String, String> headers = {
      "Content-Type"  : "application/json",
    };

    try {
      final response    = await http.post(url, headers: headers);
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      aeroLineas        = AerolineasModel.fromJson(decodedData);
    } catch (e) {
      print("No fue posible obtener las Aerolineas!. Se genero la siguinte excepcion:\n$e");
    }

    return aeroLineas;
  }





  ///Consulta de los vuelos disponibles
  ///
  ///Cosulta al servicio del pms para obtener los
  ///vuelos de la fecha proporcionada. Requiere
  ///del parametros [fecha] de tipo DateTime.
  Future<Vuelos> getVuelos(DateTime date) async {
    String url   = _config?.getFlightsServiceUrl;
    String fecha = "${date.day}/${date.month}/${date.year}";
    String authorization = 'Basic '+base64Encode(utf8.encode('$_usr:$_psw'));
    Vuelos vuelos;

    Map<String, String> headers = {
      "Content-Type"  : "application/x-www-form-urlencoded; charset=utf-8",
      "Accept"        : "application/json",
      "Authorization" : authorization
    };

    Map<String, String> body = {
      'fecha': fecha
    };

    try {
      final response    = await http.post(url, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      vuelos            = Vuelos.fromJson(decodedData);
    }  catch (e) {
      print("No fue posible obtener la lista de vuelos!. Se genero la siguinte excepcion:\n$e");
    }

    return vuelos;
  }
}