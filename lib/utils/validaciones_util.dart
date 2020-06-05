import 'package:flutter/material.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/utils/fecha_util.dart';

String isRequired(BuildContext context, String val){
  if(val == null || val.trim().isEmpty)
    return Translations.of(context).text("field_required");

  return null;
}

String isEmail(BuildContext context, String val, bool required){
  if(required){
    String s = isRequired(context, val);

    if(s!= null)
      return s;
  }

  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);

  return regExp.hasMatch(val) ? null : Translations.of(context).text("invalid_mail");
}

String isAdult(BuildContext context, bool required, {String val, String splitBy}){
  if(required){
    String s = isRequired(context, val);

    if(s!= null)
      return s;
  }

  List<String> listaValor = (val.trim()).split(splitBy);
  DateTime fecha = DateTime(int.parse(listaValor[2]), int.parse(listaValor[1]), int.parse(listaValor[0]));
  int edad = getEdad(fecha);

  return (edad >=18 ) ? null : Translations.of(context).text("adult_required");
}