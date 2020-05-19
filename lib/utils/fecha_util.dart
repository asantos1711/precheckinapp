//Convierte un String con formato(yyy-MM-dd ????)
//en formato ISO-8601
String fechaISO8601fromString(String fecha){
  if(fecha == null || fecha.isEmpty)
    return "";

  String fechaFormato;
  String fechaSplit = splitFecha(fecha);
  List<String> fechaList = fechaSplit.split("-");
  DateTime f = DateTime(int.parse(fechaList[0]),
    int.parse(fechaList[1]), 
    int.parse(fechaList[2])
  );

  fechaFormato = fechaISO8601FromDateTime(f);

  return fechaFormato;
}

//Convierte un objeto DateTime a un String 
//con formato ISO-8601
String fechaISO8601FromDateTime(DateTime fecha){
  String fechaFormato = fecha.toIso8601String();
  /*print("ISO: ${fecha.toIso8601String()}");
  print("UTC: ${fecha.toUtc()}");
  print("UTC: ${fecha.timeZoneOffset}");
  print("UTC: ${fecha.timeZoneName}");
  print("UTC: ${fecha.toLocal()}");*/
  
  if(!fechaFormato.contains('Z'))
    fechaFormato +=  'Z';

  return fechaFormato;
}


//Quita el formato del String de la fecha
String splitFecha(String fecha){

  if(fecha == null || fecha.isEmpty)
    return "";

  List<String> fechaAR = fecha.trim().split(" ");

  return (fechaAR.isNotEmpty) ? fechaAR[0] : "";
}