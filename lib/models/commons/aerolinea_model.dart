class Aerolinea {

  String fs;
  String iata;
  String icao;
  String name;
  String phoneNumber;
  String category;
  bool active;

  Aerolinea({
    this.fs          = "-",
    this.iata        = "-",
    this.icao        = "-",
    this.name        = "-",
    this.phoneNumber = "-",
    this.category    = "-",
    this.active      = false,
  });

  factory Aerolinea.fromJson(Map<String,dynamic> json){
    return new Aerolinea(
      fs          : json['fs']          ??  '',
      iata        : json['iata']        ??  '',
      icao        : json['icao']        ??  '',
      name        : json['name']        ??  '',
      phoneNumber : json['phoneNumber'] ??  '',
      category    : json['category']    ??  '',
      active      : json['active']      ??  false,
    );
  }

}