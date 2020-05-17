import 'package:flutter/material.dart';

Color backgroundBloqueado = Color(0XFFF5F5F5);

/*
 * ----------------
 * ESTILOS DE TEXTO
 * ----------------
 */

TextStyle appbarTitle = TextStyle(
  fontFamily: "Montserrat", 
  fontSize: 20.0,
);

TextStyle etiqueta = TextStyle(
  fontFamily: "Montserrat", 
  fontSize: 15.0,
);

TextStyle valor = TextStyle(
  fontFamily: "Montserrat", 
  fontWeight: FontWeight.bold,
);

TextStyle titulos = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 16.0,
  color: Color.fromARGB(255,63, 90, 166)
);



/*
 * ----------------
 * ICONOS
 * ----------------
 */
BoxDecoration boxDecorationDefault = BoxDecoration(
  border: Border(bottom: BorderSide(color: Colors.grey, width: 1))
);

BoxDecoration boxReservationUnprocessed = BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  color: Color.fromRGBO(0, 0, 0, 0.09),
);

BoxDecoration boxReservationProcessed = BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  color: Colors.white,
  border: Border(
    left   : BorderSide(color:Colors.green),
    top    : BorderSide(color:Colors.green),
    right  : BorderSide(color:Colors.green),
    bottom : BorderSide(color:Colors.green),
  )
);

/*
 * ----------------
 * ICONOS
 * ----------------
 */

Icon iconChecked = Icon(
  Icons.check_circle_outline, 
  color: Colors.green
);








