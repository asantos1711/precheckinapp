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
String fechaISO8601FromDateTime(DateTime fecha) => fecha.toIso8601String()+'-05:00';


//Convierte un String con formato(yyy-MM-dd ????)
//regresa un String con formato(yyy-MM-dd)
String splitFecha(String fecha){
  List<String> fechaAR = [];

  if(fecha == null || fecha.isEmpty)
    return "";

  if(fecha.contains("T"))
    fechaAR = fecha.trim().split("T");
  else
    fechaAR = fecha.trim().split(" ");

  return (fechaAR.isNotEmpty) ? fechaAR[0] : "";
}