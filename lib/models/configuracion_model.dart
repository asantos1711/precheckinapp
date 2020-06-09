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

  int adultAge(){
    int age = 0;
    if(groupsAdultsAge != null && groupsAdultsAge.isNotEmpty)
      age = int.parse(groupsAdultsAge);
    return age;
  }

  int minorAge(){
    int age = 0;
    if(groupsMinorsAge != null && groupsMinorsAge.isNotEmpty)
      age = int.parse(groupsMinorsAge);
    return age;
  }

  int adultEquivalence(){
    int adult = 0;
    if(adultsEquivalence != null && adultsEquivalence.isNotEmpty)
      adult = int.parse(adultsEquivalence);
    return adult;
  }

  int minorEquivalence(){
    int minor = 0;
    if(minorsEquivalence != null && minorsEquivalence.isNotEmpty)
      minor = int.parse(minorsEquivalence);
    return minor;
  }
}