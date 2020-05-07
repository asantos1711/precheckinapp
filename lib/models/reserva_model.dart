import 'package:precheckin/models/commons/especial_request_model.dart';
import 'package:precheckin/models/commons/tipo_habitacion_model.dart';
import 'package:precheckin/models/commons/result_model.dart';


class Reserva {
  String idioma;
  Result result;
  String nombreHotel;
  TipoHabitacion tipoHabitacion;
  List<EspecialRequest> especialRequest;
  Map<String,String> plana;

  Reserva({
    this.idioma,
    this.result,
    this.nombreHotel,
    this.tipoHabitacion,
    this.especialRequest,
    this.plana,
  });

  factory Reserva.formJson( Map<String,dynamic> json ){
    return Reserva(
      idioma          : json['idioma'] ?? 'EN',
      result          : json['result'] != null ? Result.fromJson( json['result'] ) : null,
      nombreHotel     : json['nombrehotel'] ?? '',
      tipoHabitacion  : json['tipohabitacion'] != null ? TipoHabitacion.fromJson(json['tipohabitacion']) : null,
      especialRequest : json['especialrequest'] != null ? List<EspecialRequest>.from( json['especialrequest'].map( (l)=> EspecialRequest.fromJson(l)) ) : [],
      plana           : Map.from(json["plana"]).map((k, v) => MapEntry<String, String>(k, v))
    );
  }
}
