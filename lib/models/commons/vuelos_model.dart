import 'package:precheckin/utils/fecha_util.dart' as futil;

class Vuelos {
  int idcliente;
  int idtrans;
  String servicio;
  String transportacion;
  String vuelollegada;
  String vuelosalida;
  String aerolinea1;
  String hora1;
  String aerolinea2;
  String hora2;
  String notas;
  String fechallegada;
  String fechasalida;
  String tipo;
  String iata;
  String iaco;
  String origen;
  String destino;

  Vuelos({
    this.idcliente      = 0,
    this.idtrans        = 0,
    this.servicio       = '',
    this.transportacion = '',
    this.vuelollegada   = '',
    this.vuelosalida    = '',
    this.aerolinea1     = '',
    this.hora1          = '',
    this.aerolinea2     = '',
    this.hora2          = '',
    this.notas          = '',
    this.fechallegada   = '',
    this.fechasalida    = '',
    this.tipo           = '',
    this.iata           = '',
    this.iaco           = '',
    this.origen         = '',
    this.destino        = '',
  });

  factory Vuelos.fromJson(Map<String,dynamic> json){

    return new Vuelos(
      idcliente       : json['idcliente'] ?? 0,
      idtrans         : json['idtrans'] ?? 0,
      servicio        : json['servicio'] ?? '',
      transportacion  : json['transportacion'] ?? '',
      vuelollegada    : json['vuelollegada'] ?? '',
      vuelosalida     : json['vuelosalida'] ?? '',
      aerolinea1      : json['aerolinea1'] ?? '',
      hora1           : json['hora1'] ?? '',
      aerolinea2      : json['aerolinea2'] ?? '',
      hora2           : json['hora2'] ?? '',
      notas           : json['notas'] ?? '',
      fechallegada    : futil.splitFecha(json['fechallegada']) ?? '',
      fechasalida     : futil.splitFecha(json['fechasalida']) ?? '',
      tipo            : json['tipo'] ?? '',
      iata            : json['iata'] ?? '',
      iaco            : json['iaco'] ?? '',
      origen          : json['origen'] ?? '',
      destino         : json['destino'] ?? '',
    );
  }

  Map<String, dynamic> toJson()=>{
    "idcliente"      : idcliente,
    "idtrans"        : idtrans,
    "servicio"       : servicio,
    "transportacion" : transportacion,
    "vuelollegada"   : vuelollegada,
    "vuelosalida"    : vuelosalida,
    "aerolinea1"     : aerolinea1,
    "hora1"          : hora1,
    "notas"          : notas,
    "fechallegada"   : fechallegada,
    "fechasalida"    : fechasalida,
    "iata"           : iata,
    "iaco"           : iaco,
    "origen"         : origen,
    "destino"        : destino,
  };
}