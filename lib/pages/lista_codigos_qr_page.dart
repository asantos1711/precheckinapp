import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/lista_qr_widget.dart';

class ListaCodigosQR extends StatelessWidget {
  List<String> _codigos;

  @override
  Widget build(BuildContext context) {
     _codigos = ModalRoute.of(context).settings.arguments;

     print(_codigos);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _imagenFondo(),
          _contenido(context),
        ],
      )
    );
  }

  Widget _imagenFondo() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        "assets/images/background.png",
        fit: BoxFit.cover,
      )
    );
  }

  Widget _contenido(BuildContext context){
    return SafeArea(
      child: Column(
        children: <Widget>[
          _logo(),
          Expanded(child: _codigosQR(context),),
          _btnNuevoCodigo(context)
        ],
      ),
    );
  }

  Widget _logo(){
    return SvgPicture.asset(
      'assets/images/sunset_logo.svg',
      semanticsLabel: 'Acme Logo',
      color: Colors.white,
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
      width: 120.0,
      margin: EdgeInsets.symmetric(vertical:14.0),
      child: RaisedButton(
        child: Text( Translations.of(context).text('nuevo_code') ), 
        shape: StadiumBorder(),
        color: Color.fromRGBO(255, 255, 255, 0.5),
        elevation: 12.0,
        onPressed:() => Navigator.pushNamed(context, "nuevoCodigo"),
      ),
    );
  }
}