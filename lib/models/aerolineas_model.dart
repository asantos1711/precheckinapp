import 'package:precheckin/models/commons/aerolinea_model.dart';

class AerolineasModel {
  List<Aerolinea> aerolineas;
  
  AerolineasModel({
    this.aerolineas
  });

  factory AerolineasModel.fromJson(Map<String, dynamic> json){
    List<Aerolinea> al = [];
    Aerolinea alDefault = new Aerolinea();

    if(json['airlines'] != null)
      al = List<Aerolinea>.from( json['airlines'].map( (a) => Aerolinea.fromJson(a) ) );

    al.add(alDefault);

    return AerolineasModel(
      aerolineas: al,
    );
  }
}