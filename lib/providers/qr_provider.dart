import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/providers/configuracion_provider.dart';

class _QRProvider{
  QRPersistence _persitence;
  List<dynamic> codigos = [];
  ConfiguracionProvider _provider;
  Configuracion _config;
  String _usr;
  String _psw;

  _QRProvider(){
    _persitence = new QRPersistence();
    _provider = new ConfiguracionProvider();
    _config   = _provider?.configuracion;
    _usr      = _config?.usrServices;
    _psw      = _config?.pswServices;
  }


  ///Validar Códigos almacenados
  ///
  ///Consulta al servicio validaQrkeyTransaccJson del PMS
  ///para validar los codigos que se encuentran almacenados
  ///en el dispositivo
  Future<List<dynamic>> validarCodigos() async {
    String uri           = _config?.validityCodesServiceUrl;
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
      //print(body);
      final response = await http.post(
        uri, 
        headers: headers, 
        body: jsonEncode(body), 
        encoding: Encoding.getByName("utf-8")
      );

      final decodedData = json.decode(response.body);
      //print("decodeData " + decodedData.toString());
      
      codigos = decodedData["codigos"]==null?[]:_setPersistenceQR(decodedData["codigos"]);
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