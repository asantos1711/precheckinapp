import 'package:precheckin/models/commons/especial_request_model.dart';
import 'package:precheckin/models/commons/tipo_habitacion_model.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';

class Reserva {
  String idioma;
  Result result;
  TipoHabitacion tipoHabitacion;
  List<EspecialRequest> especialRequest;

  Reserva({
    this.idioma,
    this.result,
    this.tipoHabitacion,
    this.especialRequest,
  });

  factory Reserva.formJson( Map<String,dynamic> json ){
    return Reserva(
      idioma : json['idioma'] ?? 'EN',
      result : json['result'] != null ? Result.fromJson( json['result'] ) : null,
      tipoHabitacion  : json['tipohabitacion'] != null ? TipoHabitacion.fromJson(json['tipohabitacion']) : null,
      especialRequest : json['especialrequest'] != null ? List<EspecialRequest>.from( json['especialrequest'].map( (l)=> EspecialRequest.fromJson(l)) ) : []
    );
  }
}

class Result {
  int idReserva;
  int idCliente;
  String fechaCheckin;
  String fechaCheckout;
  int numeroAdultos;
  int numeroAdolecentes;
  int numeroNinios;
  String planViaje;
  String requerimientos;
  String nombreTitular;
  String pais;
  String estado;
  String ciudad;
  String codigoPostal;
  String email;
  String telefono;
  List<Acompaniantes> acompaniantes;

  Result({
    this.idReserva,
    this.idCliente,
    this.fechaCheckin,
    this.fechaCheckout,
    this.numeroAdultos,
    this.numeroAdolecentes,
    this.numeroNinios,
    this.planViaje,
    this.requerimientos,
    this.nombreTitular,
    this.pais,
    this.estado,
    this.ciudad,
    this.codigoPostal,
    this.email,
    this.telefono,
    this.acompaniantes
  });

  factory Result.fromJson( Map<String,dynamic> json ){
    String estado = json['estado'] ?? "";
    estado = (estado.isEmpty || estado.trim() == "NIN") ? "-" : estado;

    return Result(
      idReserva         : json['idreserva'],
      idCliente         : json['idcliente'],
      fechaCheckin      : json['sfechaentrada'],
      fechaCheckout     : json['sfechasalida'],
      numeroAdultos     : json['noadultos'],
      numeroAdolecentes : json['noadolecentes'],
      numeroNinios      : json['noninios'],
      planViaje         : json['planviaje'],
      requerimientos    : json['requerimientos'] ?? "",
      nombreTitular     : json['nombre'],
      pais              : json['pais'] ?? "-",
      estado            : estado,
      ciudad            : json['ciudad'],
      codigoPostal      : json['cpsocio'],
      email             : json['emailhogar'] ?? "",
      telefono          : json['telefono'] ?? "",
      acompaniantes     : json['vecaco'] != null ? List<Acompaniantes>.from(json['vecaco'].map( (v) => Acompaniantes.fromJson(v) )) : []
    );
  }
}