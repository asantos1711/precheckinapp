import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:precheckin/models/reserva_model.dart';



/// Clase para proveer los servicios de pms
class PMSProvider {
  //final String _url = 'http://apihtl.sunset.com.mx:9085/GroupSunsetPMSProxyServices/app';
  final String _url = 'http://10.194.18.59:8081/GroupSunsetPMSProxyServices/app';
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
      final response = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      reserva = Reserva.formJson(decodedData);
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
      final response = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      reserva = Reserva.formJson(decodedData);

      print(reserva.result.vuelos[0].vuelollegada);
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
  Future<dynamic> actualizaHospedaje() async {
    print('actualizaHospedaje');
    Reserva reserva;
    String uri           = '$_url/actualizaHospedajeJson';
    String authorization = 'Basic '+base64Encode(utf8.encode('$_usr:$_psw'));
    print('authorization: ${authorization}');

    Map<String, String> headers = {
      "Content-Type"  : "application/x-www-form-urlencoded; charset=utf-8",
      "Accept"        : "application/json",
      "Authorization" : authorization
    };

     var body = json.encode('{"rh":{"vecaco":[{"club":0,"idcliente":2114354,"idacompaniantes":1,"nombre":"DELGADO UC, JORGE","fechanac":"1950-01-01","imagefront":"x1","imageback":"x2","imagesign":"x3","pais":"MEX","sexo":"M","idcard":"G11948254","documenttype":"P","documentexpdate":"2030-12-19","istitular":1},{"club":0,"idcliente":2114354,"idacompaniantes":2,"nombre":"WEHRLE, JAMES ROBERT JR","fechanac":"1965-01-09","imagefront":"x113","imageback":"x123","imagesign":"x133","pais":"MEX","sexo":"M","idcard":"AA275249","documenttype":"P","documentexpdate":"2035-12-19","istitular":0},{"club":0,"idcliente":2114354,"idacompaniantes":3,"nombre":"WEHRLE, ROBERT JR","fechanac":"1965-01-09","imagefront":"x113","imageback":"x123","imagesign":"x133","pais":"MEX","sexo":"M","idcard":"AX275249","documenttype":"P","documentexpdate":"2035-12-19","istitular":0}],"idreserva":2114354,"idcliente":2114354,"uclub":0,"idstatus":"R","nombre":"DELGADO UC, JORGE ","direccion":"CONOCIDO","ciudad":"Cancun1","telefono":"21312312312","emailhogar":"JADUTIGREPROGRESO@GMAIL.COM","pais":"MEX","estado":"QROO","cpsocio":"77500","usuarioregistro":"JDELGADO"},"dbdatostmp":{},"iduser":"JDELGADO","idhotel":"0"}');
    /* Map<String, String> body = {
      'qrkey': qr 
    }; */

    try
    {
      final response = await http.post(uri, headers: headers, body: body, encoding: Encoding.getByName("utf-8"));
      final decodedData = json.decode( utf8.decode(response.bodyBytes) );
      reserva = Reserva.formJson(decodedData);
    } 
    catch (e)
    {
      print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
    }
    print('se pudo');
    return reserva;
  }
}