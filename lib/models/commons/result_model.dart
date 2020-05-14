import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/models/commons/acuerdos_model.dart';
import 'package:precheckin/models/commons/tipo_habitacion_model.dart';
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
  String direccion;
  String pais;
  String estado;
  String ciudad;
  String codigoPostal;
  String email;
  String telefono;
  String status;
  Acompaniantes titular;
  List<Acompaniantes> acompaniantes;
  List<Vuelos> vuelos;
  Acuerdos acuerdos;
  TipoHabitacion tipoHabitacion;

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
    this.direccion,
    this.pais,
    this.estado,
    this.ciudad,
    this.codigoPostal,
    this.email,
    this.telefono,
    this.titular,
    this.status,
    this.acompaniantes,
    this.vuelos,
    this.acuerdos,
    this.tipoHabitacion,
  });

  factory Result.fromJson( Map<String,dynamic> json ){
    String estado = json['estado'] ?? "";
    estado = (estado.isEmpty || estado.trim() == "NIN") ? "-" : estado;

    Acompaniantes titular;
    List<Acompaniantes> acompaniantes = [];
    
    if(json['vecaco'] != null){
      List<Acompaniantes> huespedes = List<Acompaniantes>.from( json['vecaco'].map( (v) => Acompaniantes.fromJson(v) ) );
      huespedes.forEach((huesped) {
        if(huesped.istitular == true)
          titular = huesped;
        else
          acompaniantes.add(huesped);
      });
    }

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
      direccion         : json['direccion'],
      pais              : json['pais'] ?? "-",
      estado            : estado,
      ciudad            : json['ciudad'],
      codigoPostal      : json['cpsocio'],
      email             : json['emailhogar'] ?? "",
      telefono          : json['telefono'] ?? "",
      status            : json['idstatus'] ?? "",
      titular           : titular,
      acompaniantes     : acompaniantes,
      vuelos            : json['vuelos'] != null ? List<Vuelos>.from( json['vuelos'].map( (v) => Vuelos.fromJson(v) ) ) : [],
      acuerdos          : json['tarreg'] != null ? Acuerdos.fromJson(json['tarreg']) : null,
      tipoHabitacion  : json['tipohabitacion']  != null ? TipoHabitacion.fromJson(json['tipohabitacion']) : null,
    );
  }
}