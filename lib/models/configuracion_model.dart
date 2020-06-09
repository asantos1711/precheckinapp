class Configuracion {
  String usrServices;
  String pswServices;
  String getAirlinesServiceUrl;
  String getFlightsServiceUrl;
  String listaEstadosServiceUrl;
  String listaPaisesServiceUrl;
  String getReservationServiceUrl;
  String updateReservationServiceUrl;
  String licenciaScaner;
  String licenciaScanerIos;
  String groupsAdultsAge;
  String groupsMinorsAge;
  String adultsEquivalence;
  String minorsEquivalence;
  String validityCodesServiceUrl;

  Configuracion({
    this.usrServices                 = '',
    this.pswServices                 = '',
    this.getAirlinesServiceUrl       = '',
    this.getFlightsServiceUrl        = '',
    this.listaEstadosServiceUrl      = '',
    this.listaPaisesServiceUrl       = '',
    this.getReservationServiceUrl    = '',
    this.updateReservationServiceUrl = '',
    this.licenciaScaner              = '',
    this.licenciaScanerIos           = '',
    this.groupsAdultsAge             = '',
    this.groupsMinorsAge             = '',
    this.adultsEquivalence           = '',
    this.minorsEquivalence           = '',
    this.validityCodesServiceUrl     = '',
  });

  factory Configuracion.fromJson(Map<String,dynamic> json) => Configuracion(
    usrServices                 : json['usrServices'],
    pswServices                 : json['pswServices'],
    getAirlinesServiceUrl       : json['getAirlinesServiceUrl'],
    getFlightsServiceUrl        : json['getFlightsServiceUrl'],
    listaEstadosServiceUrl      : json['listaEstadosServiceUrl'],
    listaPaisesServiceUrl       : json['listaPaisesServiceUrl'],
    getReservationServiceUrl    : json['getReservationServiceUrl'],
    updateReservationServiceUrl : json['updateReservationServiceUrl'],
    licenciaScaner              : json['licenciaScaner'],
    licenciaScanerIos           : json['licenciaScanerIos'],
    groupsAdultsAge             : json['groupsAdultsAge'],
    groupsMinorsAge             : json['groupsMinorsAge'],
    adultsEquivalence           : json['adultsEquivalence'],
    minorsEquivalence           : json['minorsEquivalence'],
    validityCodesServiceUrl     : json['validityCodesServiceUrl'],
  );
}