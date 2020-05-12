import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/models/save_data_model.dart';



/// Clase para proveer los servicios de pms
class PMSProvider {
  final String _url = 'http://apihtl.sunset.com.mx:9085/GroupSunsetPMSProxyServices/app';
  //final String _url = 'http://10.194.18.59:8081/GroupSunsetPMSProxyServices/app';
  final String _usr = 'apphotel';
  final String _psw = 'hotel25012018';
  


  ///Obtiene la información de la reservación.
  ///
  ///Consula al servicio dameReservacion del PMS para obtner la información
  ///de la reservación. Requiere de los parámetros: String [hotel], es
  ///el número de hotel que se consulata y String [idreserva], es
  ///el identificador de la reservación a consultar.
  Future<Reserva> dameReservacion({String hotel="0", String idreserva}) async {
    Reserva reserva; 
    String uri           = '$_url/dameReservacion';
    String authorization = 'Basic '+base64Encode(utf8.encode('$_usr:$_psw'));

    Map<String, String> headers = {
      "Content-Type"  : "application/x-www-form-urlencoded; charset=utf-8",
      "Accept"        : "application/json",
      "Authorization" : authorization
    };

    Map<String, String> body = {
      'pnohotel'  : hotel,
      'idreserva' : "2114605"
    };

    try
    {
      final response    = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      reserva           = Reserva.formJson(decodedData);

     
    }
    catch (e)
    {
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
    }


    return reserva;
  }




  ///Obtiene la información de la reservación.
  ///
  ///Consula al servicio dameReservacionByQrkey del PMS para obtner la información
  ///de la reservación. Requiere de los parámetros: String [hotel], es
  ///el número de hotel que se consulata y String [qr], es
  ///el identificador de la reservación a consultar.
  Future<Reserva> dameReservacionByQR(String qr) async {
    Reserva reserva;
    String uri           = '$_url/dameReservacionByQrkey';
    String authorization = 'Basic '+base64Encode(utf8.encode('$_usr:$_psw'));

    Map<String, String> headers = {
      "Content-Type"  : "application/x-www-form-urlencoded; charset=utf-8",
      "Accept"        : "application/json",
      "Authorization" : authorization
    };

    Map<String, String> body = {
      'qrkey': qr 
    };

    try
    {
      final response    = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      reserva           = Reserva.formJson(decodedData);
    } 
    catch (e)
    {
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
    }

    return reserva;
  }


  ///Actualiza la infromacion de la reservacion
  ///
  ///realiza la consulta al servicio actualizaHospedajeJson para 
  ///actualizar los datos de la reserva requiere de parametro
  ///[reserva], que es del tipo [Reserva]
  Future<dynamic> actualizaHospedaje(Reserva reserva) async {
    bool status          = true;
    String uri           = '$_url/actualizaHospedajeJson';
    String authorization = 'Basic '+base64Encode(utf8.encode('$_usr:$_psw'));

    Map<String, String> headers = {
      "Content-Type"  : "application/json",
      "Accept"        : "application/json",
      "Authorization" : authorization
    };

    try
    {
      SaveData saveModel = SaveData.fromReserva(reserva);
      final body         = saveModel.toJson();
      final response     = await http.post(
        uri, 
        headers: headers, 
        body: jsonEncode(body),
        encoding: Encoding.getByName("utf-8")
      );

      status = json.decode(response.body);
    } 
    catch (e)
    {
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
      status = false;
    }
    
    return status;
  }
}