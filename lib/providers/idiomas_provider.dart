import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class _IdiomaProvider{
  List<dynamic> idiomas = [];

  ///Método para carga el contenido del archivo de cofiguracion de los idiomas
  ///
  ///Regresa un [Future] con una lista de [dynamic].
  Future<List<dynamic>> cargarIdiomas() async {
    final resp = await rootBundle.loadString("assets/json/idioma.json"); //Carga el contenido del archivo como string

    Map dataMap = json.decode(resp); //Trasforma cargado a un mapa
    idiomas = dataMap["idiomas"];  //Toma el contenido de las rutas del mapa generado

    return idiomas;
  }
}

final idiomasProvider = new _IdiomaProvider();