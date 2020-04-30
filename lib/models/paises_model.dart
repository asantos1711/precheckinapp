
class Paises {
  List<Pais> pais;

  Paises({this.pais});

  factory Paises.fromJson(List<dynamic> json) {
    List<Pais> pais = [];

    if(json.isNotEmpty)
      pais = json.map( (p) => Pais.fromJson(p) ).toList();
    
    Pais paisDefault = new Pais();
    pais.add(paisDefault);

    return Paises(
      pais: pais,
    );
  }

}


class Pais {
  String clavepais;
  String nombrepais;
  String nacionalidad;
  String claveidioma;
  String clavegrupo;
  double importerci;
  String ladainternacional;

  Pais({this.clavepais = "-", this.nombrepais = "-", this.nacionalidad = "-", this.claveidioma = "-",
      this.clavegrupo = "-", this.importerci = 0.0, this.ladainternacional = "-"});

  factory Pais.fromJson(Map<String, dynamic> json){
    return Pais(
        clavepais         : json['clavepais'],
        nombrepais        : json['nombrepais'],
        nacionalidad      : json ['nacionalidad'],
        claveidioma       : json['claveidioma'],
        clavegrupo        : json['clavegrupo'],
        importerci        : json['importerci'],
        ladainternacional : json['ladainternacional']
    );
  }


}