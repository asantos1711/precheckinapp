import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/models/save_data_model.dart';
import 'package:precheckin/providers/configuracion_provider.dart';



class PMSProvider {
  ConfiguracionProvider _provider;
  Configuracion _config;
  String _usr;
  String _psw;
  
  PMSProvider(){
    _provider = ConfiguracionProvider();
    _config   = _provider?.configuracion;
    _usr      = _config?.usrServices;
    _psw      = _config?.pswServices;
  }



  ///Obtiene la información de la reservación.
  ///
  ///Consula al servicio dameReservacionByQrkey del PMS para obtner la información
  ///de la reservación. Requiere de los parámetros: String [hotel], es
  ///el número de hotel que se consulata y String [qr], es
  ///el identificador de la reservación a consultar.
  Future<Reserva> dameReservacionByQR(String qr) async {
    Reserva reserva;
    String uri           = _config?.getReservationServiceUrl;
    String authorization = 'Basic '+base64Encode(utf8.encode('$_usr:$_psw'));

    Map<String, String> headers = {
      "Content-Type"  : "application/x-www-form-urlencoded; charset=utf-8",
      "Accept"        : "application/json",
      "Authorization" : authorization
    };

    Map<String, String> body = {
      'qrkey': qr 
    };

    try {
      uri= "http://10.194.18.59:8081/GroupSunsetPMSProxyServices/app/dameReservacionByQrkey";
      final response    = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      reserva           = Reserva.formJson(decodedData);

      if(reserva.result.titular == null)
        reserva = null;

      if(reserva.result.status.toString().trim().toLowerCase() != "r")
        reserva = null;
    }  catch (e) {
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
    }

    return reserva;
  }




  ///Actualiza la infromacion de la reservacion
  ///
  ///realiza la consulta al servicio actualizaHospedajeJson para 
  ///actualizar los datos de la reserva requiere de parametro
  ///[result], que es del tipo [Result]
  Future<dynamic> actualizaHospedaje(Result result) async {
    bool status          = true;
    String uri           = _config?.updateReservationServiceUrl;
    String authorization = 'Basic '+base64Encode(utf8.encode('$_usr:$_psw'));

    Map<String, String> headers = {
      "Content-Type"  : "application/json",
      "Accept"        : "application/json",
      "Authorization" : authorization
    };

    try {
      SaveData saveModel = SaveData.fromResult(result);
      final body         = saveModel.toJson();
      String s = jsonEncode(body);
      final response     = await http.post(
        uri, 
        headers: headers, 
        body: jsonEncode(body),
        encoding: Encoding.getByName("utf-8")
      );

      status = json.decode(response.body);
    }  catch (e) {
      print("No fue posible Guardar la información de la reservación!. Se genero la siguinte excepcion:\n$e");
      status = false;
    }
    
    return status;
  }  
}