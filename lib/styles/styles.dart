import 'package:flutter/material.dart';
import 'package:path/path.dart';

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
  color: Colors.black
)
;
TextStyle greyText = TextStyle(
  fontFamily: "Montserrat", 
  color: Color.fromRGBO(95, 96, 98, 1),
);

TextStyle blueAcentText = TextStyle(
  fontFamily: "Montserrat", 
  color: Color.fromRGBO(25, 42, 89, 1),
);
TextStyle lightBlueText = TextStyle(
  fontFamily: "Montserrat", 
  color: Color.fromRGBO(0, 165, 227, 1),
);

TextStyle onlyFont = TextStyle(
  fontFamily: "Montserrat", 
);

TextStyle titulos = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 16.0,
  color: Color.fromARGB(255,63, 90, 166)
);


TextStyle defaultCodeCapture = TextStyle(
  fontFamily: "Montserrat",
  color: Colors.white, 
  fontSize: 17, 
  fontWeight: FontWeight.w800
);

TextStyle qrCodeCapture = TextStyle(
  fontFamily: "Montserrat",
  color: Colors.black, 
  fontSize: 17, 
  fontWeight: FontWeight.w800,
  decoration: TextDecoration.underline
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








