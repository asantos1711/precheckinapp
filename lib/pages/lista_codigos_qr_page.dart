import 'package:flutter/material.dart';
import 'package:precheckin/styles/styles.dart';

import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/utils/tools_util.dart';
import 'package:precheckin/widgets/lista_qr_widget.dart';

class ListaCodigosQR extends StatelessWidget {
  List<String> _codigos;

  @override
  Widget build(BuildContext context) {
     _codigos = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          imagenFondo(),
          _contenido(context),
        ],
      )
    );
  }

  Widget _contenido(BuildContext context){
    return SafeArea(
      child: Column(
        children: <Widget>[
          logo(),
          Expanded(child: _codigosQR(context),),
          _btnNuevoCodigo(context)
        ],
      ),
    );
  }

  Widget _codigosQR(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical:10.0),
      child: ListaQR(),
    );
  }

  Widget _btnNuevoCodigo(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical:14.0),
      child: RaisedButton(
        child: Text( Translations.of(context).text('nuevo_code') ,style: greyText,), 
        shape: StadiumBorder(),
        color: Color.fromRGBO(255, 255, 255, 0.5),
        elevation: 12.0,
        onPressed:() => Navigator.pushNamed(context, "nuevoCodigo"),
      ),
    );
  }
}