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
  int adultosPorEquivalencia; //Para Guardar el número le lugares ocupados al hacer la equivalencias
  int menoresPorEquivalencia; //Para Guardar el número le lugares ocupados al hacer la equivalencias
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
    this.numeroAdultos = 0,
    this.numeroAdolecentes = 0,
    this.numeroNinios = 0,
    this.adultosPorEquivalencia = 0,
    this.menoresPorEquivalencia = 0,
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

    Acompaniantes titular = Acompaniantes.fromResultJSON(json);
    List<Acompaniantes> acompaniantes = [];
    
    if(json['vecaco'] != null){
      List<Acompaniantes> huespedes = List<Acompaniantes>.from( json['vecaco'].map( (v) => Acompaniantes.fromJson(v) ) );
      huespedes.forEach((huesped) {

        if(huesped.istitular) {
          titular.idacompaniantes = huesped?.idacompaniantes;
          titular.imagefront      = huesped?.imagefront;
          titular.imageback       = huesped?.imageback;
          titular.imagesign       = huesped?.imagesign;
          titular.fechanac        = huesped?.fechanac;
          titular.covidQuestions  = huesped?.covidQuestions;
          titular.covidQuestions.idcliente = titular?.idcliente;
          titular.covidQuestions.item = titular?.idacompaniantes;

          if(huesped?.covidQuestions?.fecha != null){
            if(huesped.covidQuestions.fecha.isNotEmpty)
              titular.responseCovid = true;
          }

        } else {
          huesped.covidQuestions.idcliente = huesped?.idcliente;
          huesped.covidQuestions.item = huesped?.idacompaniantes;
          acompaniantes.add(huesped);
          if(huesped?.covidQuestions?.fecha != null){
            if(huesped.covidQuestions.fecha.isNotEmpty)
              huesped.responseCovid = true;
          }
        }
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
      vuelos            : json['vuelos'].length > 0 ? List<Vuelos>.from( json['vuelos'].map( (v) => Vuelos.fromJson(v) ) ) : [new Vuelos()],
      acuerdos          : json['tarreg'] != null ? Acuerdos.fromJson(json['tarreg']) : null,
      tipoHabitacion    : json['tipohabitacion']  != null ? TipoHabitacion.fromJson(json['tipohabitacion']) : null,
    );
  }

  //Obtiene el numero total de menores
  int getTotalMenores() => numeroNinios + menoresPorEquivalencia;

  //Obtiene el total de los adultos
  int getTotalAdultos() => numeroAdultos + numeroAdolecentes + adultosPorEquivalencia;
}