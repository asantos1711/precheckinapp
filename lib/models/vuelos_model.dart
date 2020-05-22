class Vuelos {
  List<Vuelo> lista;

  Vuelos({this.lista});

  factory Vuelos.fromJson(List<dynamic> json) => Vuelos(
    lista: json.isEmpty ? [] : List<Vuelo>.from( json.map((v) => Vuelo.fromJson(v)) )
  );
}

class Vuelo {
  String flightId;
  String airlineName;
  String airlineCode;
  String flightNumber;

  Vuelo({
      this.flightId     = '',
      this.airlineName  = '',
      this.airlineCode  = '',
      this.flightNumber = '',
  });

  factory Vuelo.fromJson(Map<String, dynamic> json) => Vuelo(
      flightId     : json["flightId"],
      airlineName  : json["airlineName"],
      airlineCode  : json["airlineCode"],
      flightNumber : json["flightNumber"],
  );

  Map<String, dynamic> toJson() => {
      "flightId"     : flightId,
      "airlineName"  : airlineName,
      "airlineCode"  : airlineCode,
      "flightNumber" : flightNumber,
  };
}
