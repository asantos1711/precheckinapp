import 'package:flutter/material.dart';

import '../main.dart';
import 'package:precheckin/pages/HabitacionTitular.dart';


Map<String, WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder> {
    "/" : (BuildContext context) => MyHomePage(),
    "reserva" : (BuildContext context) => HabitacionTitular(),
  };


}