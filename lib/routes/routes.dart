import 'package:flutter/material.dart';

import '../main.dart';
import 'package:precheckin/pages/HabitacionTitular.dart';
import 'package:precheckin/pages/InformacionAdicional.dart';
import 'package:precheckin/pages/lista_codigos_qr_page.dart';
import 'package:precheckin/pages/CodigoAcceso.dart';
import 'package:precheckin/pages/ver_qr_page.dart';


Map<String, WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder> {
    "/"             : (BuildContext context) => MyHomePage(),
    "reserva"       : (BuildContext context) => HabitacionTitular(),
    "infoAdicional" : (BuildContext context) => InformacionAdicional(),
    "codigosQR"     : (BuildContext context) => ListaCodigosQR(),
    "nuevoCodigo"   : (BuildContext context) => CodigoAcceso(),
    "verQR"         : (BuildContext context) => VerQR(),
  };

}