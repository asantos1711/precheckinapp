import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/estados_model.dart';
import 'package:precheckin/providers/configuracion_provider.dart';


class EstadoProvider {
  ConfiguracionProvider _provider;
  Configuracion _config;

  EstadoProvider(){
    _provider = new ConfiguracionProvider();
    _config = _provider?.configuracion;
  }


  ///Provee una lista de Estados
  ///
  ///Consulta al servicio getListaEstados de PMS para obtener
  ///la lista de los estados decuerdo a los parametros String [hotel], 
  ///es el número de hotel de la reservación y String [paies] que es
  ///el codigo del pais que se consulta.
  Future<List<Estado>> getListaEstados( {String hotel, String pais = "COL"} ) async {
    List<Estado> listaEstados = [];
    Estados estados;
    final uri      = _config?.listaEstadosServiceUrl;
    final headers  = {"Content-Type": "application/x-www-form-urlencoded; charset=utf-8","Accept": "application/json"};
    final body     = { 'nohotel': hotel, "pais" : pais };

    try {

      final response = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      estados = Estados.fromJson(decodedData);
      listaEstados = estados.estado;

    } catch (e){
      print("No fue posible obtener la lista de estados!. Se genero la siguinte excepcion:\n$e");
    }

    return listaEstados;
  }




}