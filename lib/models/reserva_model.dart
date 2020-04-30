class Reserva {
  String idioma;
  Result result;

  Reserva({
    this.idioma,
    this.result
  });

  factory Reserva.formJson( Map<String,dynamic> json ){
    return Reserva(
      idioma : json['idioma'] ?? 'EN',
      result : json['result'] != null ? Result.fromJson( json['result'] ) : null
    );
  }
}

class Result {
  int id;
  String fechaCheckin;
  String fechaCheckout;
  int numeroAdultos;
  int numeroAdolecentes;
  int numeroNinios;
  String tipoHabitacion;
  String planViaje;
  String requerimientos;
  String nombreTitular;
  String pais;
  String estado;
  String ciudad;
  String codigoPostal;
  String email;
  String telefono;

  Result({
    this.id,
    this.fechaCheckin,
    this.fechaCheckout,
    this.numeroAdultos,
    this.numeroAdolecentes,
    this.numeroNinios,
    this.tipoHabitacion,
    this.planViaje,
    this.requerimientos,
    this.nombreTitular,
    this.pais,
    this.estado,
    this.ciudad,
    this.codigoPostal,
    this.email,
    this.telefono
  });

  factory Result.fromJson( Map<String,dynamic> json ){
    String estado = json['estado'] ?? "";
    estado = (estado.isEmpty || estado.trim() == "NIN") ? "-" : estado;


    return Result(
      id                : json['idreserva'],
      fechaCheckin      : json['sfechaentrada'],
      fechaCheckout     : json['sfechasalida'],
      numeroAdultos     : json['noadultos'],
      numeroAdolecentes : json['noadolecentes'],
      numeroNinios      : json['noninios'],
      tipoHabitacion    : json['tipoHabitacion'] ?? "",
      planViaje         : json['planviaje'],
      requerimientos    : json['requerimientos'] ?? "",
      nombreTitular     : json['nombre'],
      pais              : json['pais'] ?? "-",
      estado            : estado,
      ciudad            : json['ciudad'],
      codigoPostal      : json['cpsocio'],
      email             : json['emailhogar'] ?? "",
      telefono          : json['telefono'] ?? "",
    );
  }
}