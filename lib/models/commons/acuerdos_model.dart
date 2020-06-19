class Acuerdos {
  int politicas;
  int promociones;
  int reglamento;
  int avisoPrivacidad;
  int estobjdes;
  int estsanamb;
  int idcliente;
  int reglamentoCOVID;

  Acuerdos({
    this.politicas       = 0,
    this.promociones     = 0,
    this.reglamento      = 0,
    this.avisoPrivacidad = 0,
    this.estobjdes       = 0,
    this.estsanamb       = 0,
    this.idcliente       = 0,
  });

  factory Acuerdos.fromJson(Map<String, dynamic> json) => Acuerdos(
    politicas       : json['estacuest']  ?? 0,
    promociones     : json['estacuprom'] ?? 0,
    reglamento      : json['estacureg']  ?? 0,
    avisoPrivacidad : json['estavipriv'] ?? 0,
    estobjdes       : json['estobjdes']  ?? 0,
    estsanamb       : json['estsanamb']  ?? 0,
    idcliente       : json['idcliente']  ?? 0,
  );

  Map<String,dynamic> toJson() => {
    'estacuest'  : politicas,
    'estacuprom' : promociones,
    'estacureg'  : reglamento,
    'estavipriv' : avisoPrivacidad,
    'estobjdes'  : estobjdes,
    'estsanamb'  : estsanamb,
    'idcliente'  : idcliente,
  };
}