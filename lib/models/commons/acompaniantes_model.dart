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
  String sexo;
  String idcard;
  String documenttype;
  String documentexpdate;
  bool istitular;

  Acompaniantes({
    this.club,
    this.idcliente,
    this.idacompaniantes,
    this.nombre,
    this.direccion,
    this.ciudad,
    this.telefono,
    this.nomcia,
    this.dircia,
    this.ciucia,
    this.telcia,
    this.edad,
    this.parentesco,
    this.ocupacion,
    this.fechanac,
    this.imagefront,
    this.imageback,
    this.imagesign,
    this.sexo,
    this.idcard,
    this.documenttype,
    this.documentexpdate,
    this.istitular,
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
      sexo            : json['sexo'],
      idcard          : json['idcard'],
      documenttype    : json['documenttype'],
      documentexpdate : json['documentexpdate'],
      istitular       : json['istitular'] ?? false,
    );

  }
}