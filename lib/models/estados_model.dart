
class Estados{
  List<Estado> estado;

  Estados({this.estado});

  factory Estados.fromJson(List<dynamic> json){
    List<Estado> estado = [];

    if(json.isNotEmpty)
      estado = json.map( (e) => Estado.fromJson(e) ).toList();

    Estado estadoDefault = new Estado();
    estado.add(estadoDefault);

    return Estados(
      estado: estado,
    );
  }

}

class Estado{
  String clavepais;
  String claveestado;
  String nombreestado;

  Estado({this.clavepais = "-", this.claveestado = "-", this.nombreestado = "-"});

  factory Estado.fromJson(Map<String, dynamic> json){
    return Estado(
        clavepais    : json['clavepais'].toString().trim(),
        claveestado  : json['claveestado'].toString().trim(),
        nombreestado : json ['nombreestado'].toString().trim()
    );
  }

}