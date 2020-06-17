
class CovidQuestionsModel {
  int idcliente;
  int item;
  String fecha;
  String nombre;
  String apellido;
  int edad;
  String procedencia;
  String email;
  String telefono;
  String codigoArea;
  String paisesVisitados;
  String ciudadesVisitadas;
  bool enContacto;
  String fechaContacto;
  bool temperatura;
  bool tos;
  bool malestarGeneral;
  bool dificultadRespirar;
  String otrosSintomas;
  int avisoPrivacidad;

  CovidQuestionsModel({
    this.idcliente          = 0,
    this.item               = 0,
    this.fecha              = "",
    this.nombre             = "",
    this.apellido           = "",
    this.edad               = 0,
    this.procedencia        = "",
    this.email              = "",
    this.telefono           = "",
    this.codigoArea         = "",
    this.paisesVisitados    = "",
    this.ciudadesVisitadas  = "",
    this.enContacto         = false,
    this.fechaContacto      = "",
    this.temperatura        = false,
    this.tos                = false,
    this.malestarGeneral    = false,
    this.dificultadRespirar = false,
    this.otrosSintomas      = "",
    this.avisoPrivacidad    = 1
  });

  factory CovidQuestionsModel.fromJson(Map<String,dynamic> json) => CovidQuestionsModel(
    idcliente          : json['idcliente'],
    item               : json['item'],
    fecha              : json['fecha'],
    nombre             : json['nombre'],
    apellido           : json['apellido'],
    edad               : json['edad'],
    procedencia        : json['procedencia'],
    email              : json['email'],
    telefono           : json['telefono'],
    codigoArea         : json['codigoarea'],
    paisesVisitados    : json['paisesvisitados'],
    ciudadesVisitadas  : json['ciudadesvisitadas'],
    enContacto         : (json['encontacto'] == 'true')? true : false,
    fechaContacto      : json['fechacontacto'],
    temperatura        : json['temperatura'],
    tos                : json['tos'],
    malestarGeneral    : json['malestargeneral'],
    dificultadRespirar : json['dificultadrespirar'],
    otrosSintomas      : json['otrossintomas'],
    avisoPrivacidad    : json['estaviprivapp'] ?? 1,
  );

  Map<String, dynamic> toJson() => {
    "idcliente"          : idcliente,
    "item"               : item,
    "fecha"              : fecha,
    "nombre"             : nombre,
    "apellido"           : apellido,
    "edad"               : edad,
    "procedencia"        : procedencia,
    "email"              : email,
    "telefono"           : telefono,
    "codigoarea"         : codigoArea,
    "paisesvisitados"    : paisesVisitados,
    "ciudadesvisitadas"  : ciudadesVisitadas,
    "encontacto"         : enContacto,
    "fechacontacto"      : fechaContacto,
    "temperatura"        : temperatura,
    "tos"                : tos,
    "malestargeneral"    : malestarGeneral,
    "dificultadrespirar" : dificultadRespirar,
    "otrossintomas"      : otrosSintomas,
    "estaviprivapp"      : avisoPrivacidad,
  };
}