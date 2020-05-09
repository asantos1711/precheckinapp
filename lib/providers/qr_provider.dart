import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:precheckin/persitence/qr_persistence.dart';

class _QRProvider{
  QRPersistence _persitence = new QRPersistence();
  List<dynamic> codigos = [];
  final String _url = 'http://10.194.18.59:8081/GroupSunsetPMSProxyServices/app';
  final String _usr = 'apphotel';
  final String _psw = 'hotel25012018';




  ///Método para carga el contenido del archivo de de codigos_qr
  ///
  ///Regresa un [Future] con una lista de [dynamic].
  Future<List<dynamic>> cargarCodigos() async {
    final resp = await rootBundle.loadString("assets/json/codigos_qr.json"); //Carga el contenido del archivo como string

    Map dataMap = json.decode(resp); //Trasforma cargado a un mapa
    codigos = dataMap["codigos"];  //Toma el contenido de las rutas del mapa generado
    _setPersistenceQR(dataMap["codigos"]);

    return codigos;
  }




  ///Validar Códigos almacenados
  ///
  ///Consulta al servicio validaQrkeyTransaccJson del PMS
  ///para validar los codigos que se encuentran almacenados
  ///en el dispositivo
  Future<List<dynamic>> validarCodigos() async {
    String uri           = '$_url/validaQrkeyTransaccJson';
    String authorization = 'Basic '+base64Encode(utf8.encode('$_usr:$_psw'));

    Map<String, String> headers = {
      "Content-Type"  : "application/json",
      "Accept"        : "application/json",
      "Authorization" : authorization
    };

    Map<String, List<String>> body = {
      'codigos'  : _persitence.qr
    };

    try
    {
      final response = await http.post(
        uri, 
        headers: headers, 
        body: jsonEncode(body), 
        encoding: Encoding.getByName("utf-8")
      );

      final decodedData = json.decode(response.body);
      codigos = _setPersistenceQR(decodedData["codigos"]);
    }
    catch (e)
    {
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
    }

    return codigos;
  }




  //Actualiza la persistencia de los codigos,
  //evaluando la respuesta de la validación
  //de los codigos almacenados.
  List<dynamic> _setPersistenceQR(List<dynamic> codigos){
    List<String> qr = [];
    List<dynamic> codigosNuevos = [];

    codigos.forEach((c){
      if( c["estatus"] == "nousado" ){
        qr.add( c['codigo'] );
        codigosNuevos.add(c);
      }
    });

    _persitence.qr = qr;

    return codigosNuevos;
  }
}

final qrProvider = new _QRProvider();