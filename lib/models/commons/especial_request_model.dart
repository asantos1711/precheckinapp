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

  factory EspecialRequest.fromJson(Map<String, dynamic> json){

    return new EspecialRequest(
      numReporte: json['numReporte'] ?? 0,
      categoria: json['categoria'] ?? '',
      subcategoria: json['subcategoria'] ?? '',
      area: json['area'] ?? '',
      seccion: json['seccion'] ?? '',
      departamento: json['departamento'] ?? '',
      fechaReporte: json['fechaReporte'] ?? '',
      fechaSolucion: json['fechaSolucion'] ?? '',
      reporte: json['reporte'] ?? '',
      solucion: json['solucion'] ?? '',
    );

  }
}