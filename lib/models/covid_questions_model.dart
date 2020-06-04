
class CovidQuestionsModel {
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

  CovidQuestionsModel({
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
    this.otrosSintomas      = ""
  });

  factory CovidQuestionsModel.fromJson(Map<String,dynamic> json) => CovidQuestionsModel(
    fecha              : json['fecha'],
    nombre             : json['nombre'],
    apellido           : json['apellido'],
    edad               : json['edad'],
    procedencia        : json['procedencia'],
    email              : json['email'],
    telefono           : json['telefono'],
    codigoArea         : json['codigoArea'],
    paisesVisitados    : json['paisesVisitados'],
    ciudadesVisitadas  : json['ciudadesVisitadas'],
    enContacto         : json['enContacto'],
    fechaContacto      : json['fechaContacto'],
    temperatura        : json['temperatura'],
    tos                : json['tos'],
    malestarGeneral    : json['malestarGeneral'],
    dificultadRespirar : json['dificultadRespirar'],
    otrosSintomas      : json['otrosSintomas'],
  );

  Map<String, dynamic> toJson() => {
    "fecha"              : fecha,
    "nombre"             : nombre,
    "apellido"           : apellido,
    "edad"               : edad,
    "procedencia"        : procedencia,
    "email"              : email,
    "telefono"           : telefono,
    "codigoArea"         : codigoArea,
    "paisesVisitados"    : paisesVisitados,
    "ciudadesVisitadas"  : ciudadesVisitadas,
    "enContacto"         : enContacto,
    "fechaContacto"      : fechaContacto,
    "temperatura"        : temperatura,
    "tos"                : tos,
    "malestarGeneral"    : malestarGeneral,
    "dificultadRespirar" : dificultadRespirar,
    "otrosSintomas"      : otrosSintomas,
  };
}