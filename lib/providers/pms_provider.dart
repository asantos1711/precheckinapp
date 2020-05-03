import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/reserva_model.dart';



/// Clase para proveer los servicios de pms
class PMSProvider {
  


  ///Obtiene la información de la reservación.
  ///
  ///Consula al servicio dameReservacion del PMS para obtner la información
  ///de la reservación. Requiere de los parámetros: String [hotel], es
  ///el número de hotel que se consulata y String [idreserva], es
  ///el identificador de la reservación a consultar.
  Future<Reserva> dameReservacion({String hotel="0", String idreserva}) async {
    final uri      = 'http://10.194.18.59:8081/GroupSunsetPMSProxyServices/pms/dameReservacion';
    final headers  = {"Content-Type": "application/x-www-form-urlencoded; charset=utf-8","Accept": "application/json"};
    final  body    = { 'pnohotel': hotel, 'idreserva': idreserva };
    Reserva reserva;


    try {

      final response = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      reserva = Reserva.formJson(decodedData);

    } catch (e){
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
  Future<Reserva> dameReservacionByQR({String hotel="0", String qr}) async {
    final uri      = 'http://10.194.18.59:8081/GroupSunsetPMSProxyServices/pms/dameReservacionByQrkey';
    final headers  = {"Content-Type": "application/x-www-form-urlencoded; charset=utf-8","Accept": "application/json"};
    final  body    = { 'pnohotel': hotel, 'qrkey': qr };
    Reserva reserva;


    try {

      final response = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      reserva = Reserva.formJson(decodedData);

    } catch (e){
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
    }

    return reserva;
  }
}