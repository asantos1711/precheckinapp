import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/models/commons/vuelos_model.dart';


class Result {
  int idClub;
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
  List<Vuelos> vuelos;

  Result({
    this.idClub,
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
    this.acompaniantes,
    this.vuelos,
  });

  factory Result.fromJson( Map<String,dynamic> json ){
    String estado = json['estado'] ?? "";
    estado = (estado.isEmpty || estado.trim() == "NIN") ? "-" : estado;

    return Result(
      idClub            : json['uclub'],
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
      acompaniantes     : json['vecaco'] != null ? List<Acompaniantes>.from(json['vecaco'].map( (v) => Acompaniantes.fromJson(v) )) : [],
      vuelos            : json['vuelos'] != null ? List<Vuelos>.from( json['vuelos'].map( (v) => Vuelos.fromJson(v) ) ) : []
    );
  }
}