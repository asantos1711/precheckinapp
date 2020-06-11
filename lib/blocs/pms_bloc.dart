import 'package:age/age.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/models/commons/politicas_model.dart';
export 'package:precheckin/models/commons/politicas_model.dart';
import 'package:precheckin/models/covid_questions_model.dart';
import 'package:precheckin/models/reserva_model.dart';
export 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/providers/pms_provider.dart';
import 'package:precheckin/utils/fecha_util.dart';

class PMSBloc {

  static final PMSBloc _instance = new PMSBloc._();

  factory PMSBloc() => _instance;

  PMSBloc._();

  Reserva _reserva;
  Result  _result;
  PMSProvider _provider;
  int _position;
  int posRoute;
  Acompaniantes _nuevoAcompaniante;


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

  //Obtener el titular
  Acompaniantes get titular => _result?.titular;

  ///Para establecer el origen de los datos en que se va a trabajar.
  set result(Result result) => (result == null ) ? _result = _reserva.result : _result = result;

  //GET/SET nombre del titular
  String get nombreTitular => _result?.titular?.nombre;
  set nombreTitular(String nombre) {
    _result?.titular?.nombre = nombre;
    _result?.nombreTitular   = nombre;
  }

  //GET/SET fecha de nacimiento del titular
  DateTime get fnTituar => fechaByString(_result?.titular?.fechanac);
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

  //GET/SET pais del titular.
  String get pais => _result?.pais ?? "USD";
  set pais(String pais){
    _result?.pais = pais;
    _result?.titular?.pais = pais;
  }

  //GET/SET el estado del tituar
  String get estado => _result.estado;
  set estado(String estado){
    _result?.estado = estado;
    _result?.titular?.estado = estado;
  }

  //GET/SET la ciudad del titular
  String get ciudad => _result?.ciudad;
  set ciudad(String ciudad){
    _result?.ciudad = ciudad;
    _result?.titular?.ciudad = ciudad;
  }

  //GET/SET el codigo postal del titular
  String get codigoPostal => _result.codigoPostal;
  set codigoPostal(String cp){
    _result?.codigoPostal = cp;
    _result?.titular?.codigoPostal = cp;
  }

  //GET/SET aerolinea.
  String get aerolinea => (_result.vuelos.isNotEmpty) ? (_result.vuelos[0].aerolinea1 ?? "") : "";
  set aerolinea(String aerolinea) => _result?.vuelos[0]?.aerolinea1 = aerolinea;

  //GET/SET fecha de vuelo
  DateTime get fechaVuelo => _result.vuelos[0].fechasalida.isNotEmpty ? DateTime.parse(_result.vuelos[0].fechasalida) : DateTime.now();
  set fechaVuelo(DateTime fecha) => _result.vuelos[0].fechasalida = fechaISO8601FromDateTime(fecha);

  //GET/SET número del vuelo.
  String get numeroVuelo => _result.vuelos[0].vuelollegada;
  set numeroVuelo(String numero) => _result.vuelos[0].vuelollegada = numero;
  
  //GET/SET reglamento.
  int get reglamento => _result?.acuerdos?.reglamento;
  set reglamento(int val) => _result?.acuerdos?.reglamento = val;

  //GET/SET promoción.
  int get promocion => _result?.acuerdos?.promociones;
  set promocion(int val) => _result?.acuerdos?.promociones = val;

  //GET/SET avido privacidad.
  int get avisoPrivacidad => _result?.acuerdos?.avisoPrivacidad;
  set avisoPrivacidad(int val) => _result?.acuerdos?.avisoPrivacidad = val;

  //GET/SET reglas COVID.
  int get reglasCovid => _result?.acuerdos?.reglamentoCOVID;
  set reglasCovid(int val) => _result?.acuerdos?.reglamentoCOVID = val;

  //GET/SET politicas y procesos.
  int get politicasProcesos => _result?.acuerdos?.estsanamb;
  set politicasProcesos(int val){
    _result.acuerdos.estsanamb = val;
    _result.acuerdos.estobjdes = val;
    _result.acuerdos.politicas = val;
  }
  set initCheckbox(int val){
    promocion         = val;
    avisoPrivacidad   = val;
    reglamento        = val;
    politicasProcesos = val;
    reglasCovid       = val;
  }

  //Obtner la lista de politicas
  List<Politicas> get politicas => _reserva.politicas;

  //Determinar si se debe de bloquear el boton de continuar
  //por no aceptar los terminos
  bool bloquearBoton(){
    bool reg = (reglamento!=1) ? true : false;
    bool pol = (politicasProcesos!=1) ? true : false;
    bool avi = (avisoPrivacidad!=1) ? true : false;
    bool cvd = (reglasCovid!=1) ? true : false;

    return (reg || pol || avi || cvd);
  }

  //GET/SET Firma del titular
  String get signTitular => _result?.titular?.imagesign;
  set signTitular(String imagesign) => _result?.titular?.imagesign = imagesign;

  //GET/SET email del titular
  String get emailTitular => _result?.email ?? ''; 
  set emailTitular(String email) => _result?.email = email;

  //GET/SET teléfono del titular
  String get telefonoTitular => _result?.telefono ?? '';
  set telefonoTitular(String telefono) => _result?.telefono = telefono;

  //GET id del Cliente
  int get idCliente => _result.idCliente;

  //Determinar si la habitación tiene capacidad para mas acompañantes.
  bool get habilitarAddAcompaniantes {
    int densidadAdultos =  _result?.tipoHabitacion?.maxAdultos;
    int densidadMenores = _result?.tipoHabitacion?.maxMenores;
    int adultosReserva  = _result.getTotalAdultos();
    int menoresReserva  = _result.getTotalMenores();

    if(densidadMenores <= 0){
      adultosReserva = (adultosReserva + menoresReserva);
      adultosEquivalencia = menoresReserva;
    }
    else if(densidadMenores < menoresReserva){
      adultosReserva = adultosReserva + (menoresReserva - densidadMenores);
      adultosEquivalencia = (menoresReserva - densidadMenores);
    }

    if(adultosReserva > densidadAdultos){
      menoresReserva = menoresReserva + (adultosReserva - densidadAdultos);
      menoresEquivalencia = (adultosReserva - densidadAdultos) * 2;
    }

    return ((adultosReserva < densidadAdultos) || (menoresReserva < densidadMenores)) ? true : false;
  }
  //Establecer adultos y menores por equivalencia.
  set adultosEquivalencia(int adultos) => _result.adultosPorEquivalencia = adultos;
  set menoresEquivalencia(int menores) => _result.menoresPorEquivalencia = menores;

  //GET Lista de Acompañantes.
  List<Acompaniantes> get acompaniantes => _result?.acompaniantes;
  set acompaniantes(List<Acompaniantes> acompaniantes) => _result.acompaniantes = acompaniantes;

  //ADD acompañante
  set addAcompaniante(Acompaniantes acompaniante) => _result.acompaniantes.add(acompaniante);

  //GET total Adultos
  int get totalAdoultos{
    int total = _result.tipoHabitacion.maxAdultos - _result.getTotalAdultos();
    return (total <= 0) ? 0 : total;
  }

  //GET total Menores
  int get totalMenores {
    int total = _result.tipoHabitacion.maxMenores - _result.getTotalMenores();
    return (total <= 0) ? 0 : total;
  }

  //Incrementar Adultos
  set incrementarAdultos(int val) => _result.numeroAdultos = _result.numeroAdultos + val;
  set incrementarAdolecentes(int val) => _result.numeroAdolecentes = _result.numeroAdolecentes + val;
  set incrementarNinios(int val) => _result.numeroNinios = _result.numeroNinios + val;

  //Incrementar Menores y adultos por Equivalencia
  set incrementarMenoresEquivalencia(int val) => _result.menoresPorEquivalencia = _result.menoresPorEquivalencia + val ;
  set incrementarAdultosEquivalencia(int val) => _result.adultosPorEquivalencia = _result.adultosPorEquivalencia + val;

  //Establecer la posición del acompañante
  int getposition() => _position;
  set position(int p) => _position = p;

  //Obtener el acompañante o el titular.
  Acompaniantes getAcompaniante(){
     if(_position == -1)
      return _result?.titular;
    else if(_position == -2)
      return _nuevoAcompaniante;
    else
      return _result?.acompaniantes[_position];
  }

  //Asignar las respuestas al acompañante.
  void setCuestionarioCovid(CovidQuestionsModel q){
    if(_position == -1) {
      _result?.titular?.responseCovid = true;
      _result?.titular?.covidQuestions = q;
    } else if(_position == -2){
      _nuevoAcompaniante.responseCovid = true;
      _nuevoAcompaniante.covidQuestions = q;
    } else {
       _result?.acompaniantes[_position]?.responseCovid = true;
       _result?.acompaniantes[_position]?.covidQuestions = q;
    }
  }

  //Verificar si se contestó la encuesta de salud
  bool verificarEncuenta(int posicion) {
    if(posicion == -1) 
      return _result?.titular?.responseCovid ?? false;
    else if(posicion == -2)
      return _nuevoAcompaniante?.responseCovid ?? false;
    else
    return _result?.acompaniantes[posicion]?.responseCovid ?? false;
  }

  String get paisByPosicion {
    String pais = _result?.pais;

    if(_position == -1) {
      if(_result.titular.pais != null)
        pais =_result.titular.pais;

    } else if(_position == -2){
      if(_nuevoAcompaniante.pais != null)
        pais = _nuevoAcompaniante.pais ?? 'USA';

    } else {
      if(_result?.acompaniantes[_position]?.pais != null)
        pais = _result?.acompaniantes[_position]?.pais;
        
    }

    return pais;
  }

  set paisByPosicion(String pais){
    if(_position == -1) {
      _result?.titular?.pais = pais;
      _result?.pais = pais;
      _result?.estado = '';
    } else if(_position == -2){
      _nuevoAcompaniante.pais = pais;
    } else {
       _result?.acompaniantes[_position]?.pais = pais;
    }
  }

  //Verificar si las encuestas de los acompañantes estan contestadas.
  bool verificarEncuestas(){
    if(_result?.acompaniantes == null || _result.acompaniantes.isEmpty)
      return true;

    bool status = true;

    for (var i = 0; i < _result.acompaniantes.length; i++) {
      if(!(_result.acompaniantes[i].responseCovid)){
        status = false;
        break;
      }
    }

    return status;
  }

  //Inicializar el objeto para el nuevo acompañante
  void inicializarAcompaniante() {
    _nuevoAcompaniante                 = new Acompaniantes();
    _nuevoAcompaniante.fechanac        = new DateTime.now().toString();
    _nuevoAcompaniante.edad            = '0';
    _nuevoAcompaniante.club            = int.parse(idHotel);
    _nuevoAcompaniante.idcliente       = idCliente;
    _nuevoAcompaniante.idacompaniantes = 0;
    _nuevoAcompaniante.istitular       = false;
  }

  //Regresar el objeto del nuevo acompañante.
  Acompaniantes get nuevoAcompaniante => _nuevoAcompaniante;

  //Actualizar la información de la reserva
  Future<bool> actualizaHospedaje() async => await _provider.actualizaHospedaje(_result);
}