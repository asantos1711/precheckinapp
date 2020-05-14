import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/aerolineas_model.dart';

class AerolineaProvider {


  ///Consulta al pms para traer las aerolineas disponibles
  Future<AerolineasModel> getAerolineas() async {
    AerolineasModel aeroLineas;

    String uri = 'http://acuarius.it.sunset.com.mx:8085/GroupSunsetPMSProxyServices/pms/getListaAerolineas';
    Map<String, String> headers = {
      "Content-Type"  : "application/json",
    };

    try
    {
      final response    = await http.post(uri, headers: headers);
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      aeroLineas        = AerolineasModel.fromJson(decodedData);
    }
    catch (e)
    {
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
    }

    return aeroLineas;
  }

}