
String vueloFechaLlegada(String fecha){

  if(fecha == null || fecha.isEmpty)
    return "";

  List<String> fechaAR = fecha.trim().split(" ");

  return (fechaAR.isNotEmpty) ? fechaAR[0] : "";
}