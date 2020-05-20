class TipoHabitacion{
  int club;
  int activo;
  int agrupacion;
  String idtipohabit;
  String descripcion;
  String idtipotc;
  String tipo;
  String densidad;
  int maxOcupantes;
  int maxAdultos;
  int maxMenores;

  TipoHabitacion({
    this.club,
    this.activo,
    this.agrupacion,
    this.idtipohabit,
    this.descripcion,
    this.idtipotc,
    this.tipo,
    this.densidad = '',
    this.maxOcupantes = 0,
    this.maxAdultos = 0,
    this.maxMenores = 0,
  });

  factory TipoHabitacion.fromJson(Map<String,dynamic> json){
    int maxDensidad = 0;
    int maxAd = 0;
    int maxMn = 0;
    List<String> densidadAR = json['densidad'] != null ? json['densidad'].split('.') : [];

    densidadAR.forEach((d) => maxDensidad += int.parse(d));

    if(densidadAR.isNotEmpty){
      maxAd = int.parse(densidadAR[0]);

      if(densidadAR.length > 1)
        maxMn = int.parse(densidadAR[1]);
    }
    
    return new TipoHabitacion(
      club         : json['club']        ?? 0,
      activo       : json['activo']      ?? 0,
      agrupacion   : json['agrupacion']  ?? 0,
      idtipohabit  : json['idtipohabit'] ?? '',
      descripcion  : json['descripcion'] ?? '',
      idtipotc     : json['idtipotc']    ?? '',
      tipo         : json['tipo']        ?? '',
      densidad     : json['densidad']    ?? '',
      maxOcupantes : maxDensidad,
      maxAdultos   : maxAd,
      maxMenores   : maxMn,  
    );
  }
}