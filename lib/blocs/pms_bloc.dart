import 'package:age/age.dart';
import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/providers/pms_provider.dart';
import 'package:precheckin/utils/fecha_util.dart';

class PMSBloc {

  static final PMSBloc _instance = new PMSBloc._();

  factory PMSBloc(){
    return _instance;
  }

  PMSBloc._();

  Reserva _reserva;
  Result  _result;
  PMSProvider _provider;


  ///Inicializa la instancia de Reserva
  ///
  ///Inicializa la propiedad [_reserva] de tipo
  ///Reserva. Requiere del parámetros [qr] de
  ///tipo Strin pra funcionar.
  Future<bool> setReserva(String qr) async {
    _provider = new PMSProvider();
    _reserva = await _provider.dameReservacionByQR(qr);
    _reserva?.codigo = qr;

    return (_reserva != null);
  }

  /// Retorna la instancia de la Reserva.
  Reserva get reserva => _reserva;

  ///Verifica si la reserva tiene reservacione ligadas.
  bool get tieneLigadas => _reserva?.ligadas.isNotEmpty;

  ///Obtiene el result
  Result get result => _result;

  ///Para establecer el origen de los datos en que se va a trabajar.
  set result(Result result) => (result == null ) ? _result = _reserva.result : _result = result;

  //Obtiene el nombre del titular
  String get nombreTitular => _result?.titular?.nombre;

  //Establece el nombre del titular
  set nombreTitular(String nombre) {
    _result?.titular?.nombre = nombre;
    _result?.nombreTitular   = nombre;
  }

  //Obtiene la fecha de nacimiento del titular
  DateTime get fnTituar => fechaByString(_result?.titular?.fechanac);

  //Establece la fecha de nacimiento del titular
  set fnTitular(String fecha) => _result?.titular?.fechanac = fecha;

  //Obtener la edad del titular.
  int get edadTitular {
    DateTime fecha = fnTituar;

    int age = (fecha == null) ? 0 : Age.dateDifference(
      fromDate      : fecha,
      toDate        : DateTime.now(),
      includeToDate : false
    ).years;
      
    return age;
  }

  //Obtener el id del hotel de la reserva
  String get idHotel => _result?.idClub.toString() ?? "0";

  //Obtener el pais del titular.
  String get pais => _result?.pais ?? "USD";

  //Establecer el pais del tituar
  set pais(String pais){
    _result?.pais = pais;
    _result?.titular?.pais = pais;
  }

  //Obtner el estado del tituar
  String get estado => _result.estado;

  //Establecer el estado al titular
  set estado(String estado){
    _result?.estado = estado;
    _result?.titular?.estado = estado;
  }

  //Obtiene la ciudad del titular
  String get ciudad => _result?.ciudad;

  //Establece la ciudad del titular
  set ciudad(String ciudad){
    _result?.ciudad = ciudad;
    _result?.titular?.ciudad = ciudad;
  }

  //Obtiene el codigo postal del titular
  String get codigoPostal => _result.codigoPostal;

  //Establece el codigo postal del titular
  set codigoPostal(String cp){
    _result?.codigoPostal = cp;
    _result?.titular?.codigoPostal = cp;
  }

  //Obtner la aerolinea.
  String get aerolinea => (_result.vuelos.isNotEmpty) ? (_result.vuelos[0].aerolinea1 ?? "") : "";

  //Establecer la aerolinea.
  set aerolinea(String aerolinea) => _result?.vuelos[0]?.aerolinea1 = aerolinea;

  //get/set fecha de vuelo
  DateTime get fechaVuelo => _result.vuelos[0].fechasalida.isNotEmpty ? DateTime.parse(_result.vuelos[0].fechasalida) : DateTime.now();
  set fechaVuelo(DateTime fecha) => _result.vuelos[0].fechasalida = fechaISO8601FromDateTime(fecha);

  //get/set número del vuelo.
  String get numeroVuelo => _result.vuelos[0].vuelollegada;
  set numeroVuelo(String numero) => _result.vuelos[0].vuelollegada = numero;

  //get/set promoción.
  int get promocion => _result?.acuerdos?.promociones;
  set promocion(int val) => _result?.acuerdos?.promociones = val;

  //get/set promoción.
  int get avisoPrivacidad => _result?.acuerdos?.avisoPrivacidad;
  set avisoPrivacidad(int val) => _result?.acuerdos?.avisoPrivacidad = val;

  //get/set reglamento.
  int get reglamento => _result?.acuerdos?.reglamento;
  set reglamento(int val) => _result?.acuerdos?.reglamento = val;

  //get/set politicas y procesos.
  int get politicasProcesos => _result?.acuerdos?.estsanamb;
  set politicasProcesos(int val){
    _result.acuerdos.estsanamb = val;
    _result.acuerdos.estobjdes = val;
    _result.acuerdos.politicas = val;
  }

  //Determinar si la habitación tiene capacidad para mas acompañantes.
  bool get addAcompaniantes => ((_result.getTotalAdultos() < _result?.tipoHabitacion?.maxAdultos) || (_result.getTotalMenores() < _result?.tipoHabitacion?.maxMenores)) ? true : false;

  String get signTitular => _result?.titular?.imagesign;
  set signTitular(String imagesign) => _result?.titular?.imagesign;


}