import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/paises_model.dart';
import 'package:precheckin/providers/configuracion_provider.dart';

class PaisProvider{
  ConfiguracionProvider _provider;
  Configuracion _config;

  PaisProvider(){
    _provider = new ConfiguracionProvider();
    _config = _provider?.configuracion;
  }


  ///Provee una lista de Paises
  ///
  ///Consulta al servicio getListaPaises de PMS para obtener
  ///la lista de los paises. El parametro String [hotel], 
  ///es el número de hotel de la reservación.
  Future<List<Pais>> getListaPaises( String hotel ) async {
    List<Pais> listaPaises = [];
    Paises paises;
    final uri      = _config?.listaPaisesServiceUrl;
    final headers  = {"Content-Type": "application/x-www-form-urlencoded; charset=utf-8","Accept": "application/json"};
    final body     = { 'nohotel': hotel };

    try {
      final response = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      paises = Paises.fromJson(decodedData);
      listaPaises = paises.pais;
    } catch (e){
      print("No fue posible obtener la lista de paises!. Se genero la siguinte excepcion:\n$e");
    }

    return listaPaises;
  }

}