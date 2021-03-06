import 'package:flutter/material.dart';
import 'package:precheckin/pages/HabitacionTitular.dart';
import 'package:precheckin/pages/InformacionAdicional.dart';
import 'package:precheckin/pages/acompaniantes_page.dart';
import 'package:precheckin/pages/lista_reservas_page.dart';
import 'package:precheckin/pages/questions_covid.dart';

import '../main.dart';
import 'package:precheckin/pages/ChooseLanguage.dart';
import 'package:precheckin/pages/lista_codigos_qr_page.dart';
import 'package:precheckin/pages/CodigoAcceso.dart';
import 'package:precheckin/pages/ver_qr_page.dart';


Map<String, WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder> {
    "/"             : (BuildContext context) => MyHomePage(),
    "idioma"        : (BuildContext context) => ChooseLanguage(),
    "litaReserva"   : (BuildContext context) => ListaReservas(),
    "codigosQR"     : (BuildContext context) => ListaCodigosQR(),
    "nuevoCodigo"   : (BuildContext context) => CodigoAcceso(),
    "verQR"         : (BuildContext context) => VerQR(),
    "infoTitular"   : (BuildContext context) => HabitacionTitular(),
    "infoAdicional" : (BuildContext context) => InformacionAdicional(),
    "addHuesped"    : (BuildContext context) => AcompaniantesPage(),
    "questionsCovid": (BuildContext context) => QuestionsCovidPage(),
  };

}