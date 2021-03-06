import 'package:precheckin/models/covid_questions_model.dart';

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
  bool responseCovid;
  CovidQuestionsModel covidQuestions;

  Acompaniantes({
    this.club,
    this.idcliente,
    this.idacompaniantes = 1,
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
    this.covidQuestions,
    this.responseCovid = false
  });

  factory Acompaniantes.fromJson(Map<String,dynamic> json){
    //print(json['istitular']);
    //print(json['cuestionariocovid']);

    return Acompaniantes(
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
    covidQuestions  : json['cuestionariocovid']!=null ? CovidQuestionsModel.fromJson(json['cuestionariocovid']): new CovidQuestionsModel()
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
      pais            : json['pais'] ?? "-",
      istitular       : true,
      estado          : estado,
      codigoPostal    : json['cpsocio'] ?? "",
      responseCovid   : json['responseCovid'],
      covidQuestions  : json['cuestionariocovid']!= null ? CovidQuestionsModel.fromJson(json['cuestionariocovid']) : new CovidQuestionsModel(),
    );
  }
}