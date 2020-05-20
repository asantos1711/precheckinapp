import 'package:precheckin/models/commons/especial_request_model.dart';
import 'package:precheckin/models/commons/politicas_model.dart';
import 'package:precheckin/models/commons/result_model.dart';
export 'package:precheckin/models/commons/result_model.dart';

class Reserva {
  String idioma;
  Result result;
  String nombreHotel;
  String codigo;
  List<EspecialRequest> especialRequest;
  Map<String,String> plana;
  List<Result> ligadas;
  List<Politicas> politicas;

  Reserva({
    this.idioma,
    this.result,
    this.nombreHotel,
    this.codigo,
    this.especialRequest,
    this.plana,
    this.ligadas,
    this.politicas,
  });

  factory Reserva.formJson( Map<String,dynamic> json ){
    List<Result> rl = [];

    if(json['reservasligadas'] != null)
      rl = List<Result>.from(json['reservasligadas'].map((r) => Result.fromJson(r)));

    return Reserva(
      idioma          : json['idioma'] ?? 'EN',
      result          : json['result'] != null ? Result.fromJson( json['result'] ) : null,
      nombreHotel     : json['nombrehotel'] ?? '',
      codigo          : "",
      especialRequest : json['especialrequest'] != null ? List<EspecialRequest>.from( json['especialrequest'].map( (l)=> EspecialRequest.fromJson(l)) ) : [],
      plana           : Map.from(json["plana"]).map((k, v) => MapEntry<String, String>(k, v)),
      ligadas         : rl ,
      politicas       : json['politicasyreglamentos'] != null ? List<Politicas>.from( json['politicasyreglamentos'].map( (p)=>Politicas.fromJson(p) )) : []
    );
  }
}