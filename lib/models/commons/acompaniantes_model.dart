import 'package:precheckin/models/commons/result_model.dart';

class Acompaniantes{
  int club;
  int idcliente;
  int idacompaniantes;
  String nombre;
  String direccion;
  String ciudad;
  String telefono;
  String nomcia;
  String dircia;
  String ciucia;
  String telcia;
  String edad;
  String parentesco;
  String ocupacion;
  String fechanac;
  String imagefront;
  String imageback;
  String imagesign;
  String pais;
  String sexo;
  String idcard;
  String documenttype;
  String documentexpdate;
  bool istitular;
  String estado;
  String codigoPostal;

  Acompaniantes({
    this.club,
    this.idcliente,
    this.idacompaniantes = null,
    this.nombre = '',
    this.direccion = '',
    this.ciudad = '',
    this.telefono = '',
    this.nomcia = '',
    this.dircia = '',
    this.ciucia = '',
    this.telcia = '',
    this.edad = '',
    this.parentesco = '',
    this.ocupacion = '',
    this.fechanac = '',
    this.imagefront = '',
    this.imageback = '',
    this.imagesign = '',
    this.pais = '',
    this.sexo = '',
    this.idcard = '',
    this.documenttype = '',
    this.documentexpdate = '',
    this.istitular = false,
    this.estado = '',
    this.codigoPostal = '',
  });

  factory Acompaniantes.fromJson(Map<String,dynamic> json){

    return new Acompaniantes(
      club            : json['club'],
      idcliente       : json['idcliente'],
      idacompaniantes : json['idacompaniantes'],
      nombre          : json['nombre'],
      direccion       : json['direccion'],
      ciudad          : json['ciudad'],
      telefono        : json['telefono'],
      nomcia          : json['nomcia'],
      dircia          : json['dircia'],
      ciucia          : json['ciucia'],
      telcia          : json['telcia'],
      edad            : json['edad'],
      parentesco      : json['parentesco'],
      ocupacion       : json['ocupacion'],
      fechanac        : json['fechanac'],
      imagefront      : json['imagefront'],
      imageback       : json['imageback'],
      imagesign       : json['imagesign'],
      pais            : json['pais'],
      sexo            : json['sexo'],
      idcard          : json['idcard'],
      documenttype    : json['documenttype'],
      documentexpdate : json['documentexpdate'],
      istitular       : json['istitular'] ?? false,
      estado          : json['estado'] ?? '',
      codigoPostal    : json['cpsocio'] ?? '',
    );
  }


  

  factory Acompaniantes.fromResult(Result result){

    return Acompaniantes(
      club            : result.idClub,
      idcliente       : result.idCliente,
      idacompaniantes : result.idCliente,
      nombre          : result.nombreTitular,
      direccion       : result.direccion,
      ciudad          : result.ciudad,
      telefono        : result.telefono,
      nomcia          : "",
      dircia          : "",
      ciucia          : "",
      telcia          : "",
      edad            : "",
      parentesco      : "",
      ocupacion       : "",
      fechanac        : "",
      imagefront      : "",
      imageback       : "",
      imagesign       : "",
      pais            : result.pais,
      sexo            : "",
      idcard          : "",
      documenttype    : "",
      documentexpdate : "",
      istitular       : true,
      estado          : result.estado,
      codigoPostal    : result.codigoPostal
    );

  }


  

  factory Acompaniantes.fromResultJSON(Map<String,dynamic> json){
    String estado = json['estado'] ?? "";
    estado = (estado.isEmpty || estado.trim() == "NIN") ? "-" : estado;

    return Acompaniantes(
      club            : json['uclub'] ?? "",
      idcliente       : json['idcliente'] ?? "",
      idacompaniantes : null,
      nombre          : json['nombre'] ?? "",
      direccion       : json['direccion'] ?? "",
      ciudad          : json['ciudad'] ?? "",
      telefono        : json['telefono'] ?? "",
      nomcia          : "",
      dircia          : "",
      ciucia          : "",
      telcia          : "",
      edad            : "",
      parentesco      : "",
      ocupacion       : "",
      fechanac        : "",
      imagefront      : "",
      imageback       : "",
      imagesign       : "",
      pais            : json['pais'] ?? "-",
      sexo            : "",
      idcard          : "",
      documenttype    : "",
      documentexpdate : "",
      istitular       : true,
      estado          : estado,
      codigoPostal    : json['cpsocio'] ?? ""
    );

  }
}