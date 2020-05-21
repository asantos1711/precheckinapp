import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/aerolineas_model.dart';
import 'package:precheckin/models/vuelos_model.dart';

class AerolineaProvider {
  final String _usr = 'apphotel';
  final String _psw = 'hotel25012018';



  ///Consulta al servicio getListaAerolineas
  ///para obtener la lista de las aerolineas  disponibles.
  Future<AerolineasModel> getAerolineas() async {
    AerolineasModel aeroLineas;
    String url = 'http://acuarius.it.sunset.com.mx:8085/GroupSunsetPMSProxyServices/pms/getListaAerolineas';
    
    Map<String, String> headers = {
      "Content-Type"  : "application/json",
    };

    try {
      final response    = await http.post(url, headers: headers);
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      aeroLineas        = AerolineasModel.fromJson(decodedData);
    } catch (e) {
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
    }

    return aeroLineas;
  }





  ///Consulta de los vuelos disponibles
  ///
  ///Cosulta al servicio del pms para obtener los
  ///vuelos de la fecha proporcionada. Requiere
  ///del parametros [fecha] de tipo DateTime.
  Future<Vuelos> getVuelos(DateTime date) async {
    String url   = "http://apihtl.sunset.com.mx:9085/GroupSunsetPMSProxyServices/app/getListArrivalCun";
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