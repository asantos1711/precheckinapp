import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheckin/tools/translation.dart';

import 'package:precheckin/widgets/qr_widget.dart';

class VerQR extends StatelessWidget {
  String _qr;



  @override
  Widget build(BuildContext context) {
    _qr = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _imagenFondo(),
          _contenido( context ),
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

  Widget _contenido( BuildContext context ){
    return SafeArea(
      child: Column(
        children: <Widget>[
          _logo(),
          Expanded(child: _codigosQR(),),
          _btnNuevoCodigo(context)
        ],
      ),
    );
  }

   Widget _logo(){
    return Container(
      width: double.infinity,
      child: SvgPicture.asset(
        'assets/images/sunset_logo.svg',
        semanticsLabel: 'Acme Logo',
        color: Colors.white,
      ),
    );
  }


  Widget _codigosQR(){
    return Container(
      margin: EdgeInsets.symmetric(vertical:100.0),
      child: QRCode(
        code: _qr,
        showText: true,
      )
    );
  }


  Widget _btnNuevoCodigo( BuildContext context ){
    return Container(
      width: 120.0,
      margin: EdgeInsets.symmetric(vertical:14.0),
      child: RaisedButton(
        child: Text( Translations.of(context).text('atras') ), 
        shape: StadiumBorder(),
        color: Color.fromRGBO(255, 255, 255, 0.5),
        elevation: 12.0,
        onPressed:() => Navigator.pop( context ),
      ),
    );
  }


}