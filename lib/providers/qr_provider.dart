import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:precheckin/persitence/qr_persistence.dart';

class _QRProvider{
  QRPersistence _persitence = new QRPersistence();
  List<dynamic> codigos = [];




  ///Método para carga el contenido del archivo de de codigos_qr
  ///
  ///Regresa un [Future] con una lista de [dynamic].
  Future<List<dynamic>> cargarCodigos() async {
    final resp = await rootBundle.loadString("assets/json/codigos_qr.json"); //Carga el contenido del archivo como string

    Map dataMap = json.decode(resp); //Trasforma cargado a un mapa
    codigos = dataMap["codigos"];  //Toma el contenido de las rutas del mapa generado
    _setPersistenceQR();

    return codigos;
  }




  //Actualiza la persistencia de los codigos, con los que vienen del servicio.
  void _setPersistenceQR(){
    List<String> qr = [];

    codigos.forEach( (codigo){
      qr.add( codigo['codigo'] );
    } );

    _persitence.qr = qr;
  }
}

final qrProvider = new _QRProvider();