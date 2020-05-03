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

  TipoHabitacion({
    this.club,
    this.activo,
    this.agrupacion,
    this.idtipohabit,
    this.descripcion,
    this.idtipotc,
    this.tipo,
    this.densidad,
    this.maxOcupantes = 0,
  });

  factory TipoHabitacion.fromJson(Map<String,dynamic> json){
    List<String> densidadAR = json['densidad'] != null ? json['densidad'].split('.') : [];
    int maxDensidad = 0;

    densidadAR.forEach( (d){
      maxDensidad += int.parse(d);
    } ) ;
    
    return new TipoHabitacion(
      club : json['club'] ?? 0,
      activo : json['activo'] ?? 0,
      agrupacion : json['agrupacion'] ?? 0,
      idtipohabit : json['idtipohabit'] ?? '',
      descripcion : json['descripcion'] ?? '',
      idtipotc : json['idtipotc'] ?? '',
      tipo : json['tipo'] ?? '',
      densidad : json['densidad'] ?? '',
      maxOcupantes : maxDensidad,
    );
  }
}