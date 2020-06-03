class EspecialRequest {
  int numReporte;
  String categoria;
  String subcategoria;
  String area;
  String seccion;
  String departamento;
  String fechaReporte;
  String fechaSolucion;
  String reporte;
  String solucion;

  EspecialRequest({
    this.numReporte,
    this.categoria,
    this.subcategoria,
    this.area,
    this.seccion,
    this.departamento,
    this.fechaReporte,
    this.fechaSolucion,
    this.reporte,
    this.solucion,
  });

  factory EspecialRequest.fromJson(Map<String, dynamic> json) => EspecialRequest(
      numReporte    : json['numReporte'] ?? 0,
      categoria     : json['categoria'] != null ? json['categoria'].trim() : '',
      subcategoria  : json['subcategoria'] != null ? json['subcategoria'].trim() : '',
      area          : json['area'] != null ? json['area'].trim() : '',
      seccion       : json['seccion'] != null ? json['seccion'].trim() : '',
      departamento  : json['departamento'] != null ? json['departamento'].trim() : '',
      fechaReporte  : json['fechaReporte'] != null ? json['fechaReporte'].trim() : '',
      fechaSolucion : json['fechaSolucion'] != null ? json['fechaSolucion'] : '',
      reporte       : json['reporte'] != null ? json['reporte'].trim() : '',
      solucion      : json['solucion'] != null ? json['solucion'] : '',
    );
}