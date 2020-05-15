import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheckin/widgets/qr_widget.dart';

class VerQR extends StatelessWidget {
  String _qr;
  static GlobalKey screen = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    _qr = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _imagenFondo(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _logo(),
                  _codigosQR(context)
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home, color: Colors.white, size: 35.0,),
        onPressed: () => Navigator.pushNamed(context, 'idioma'),
        backgroundColor: Color.fromRGBO(191, 52, 26, 1),
        elevation: 15.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _imagenFondo() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          "assets/images/background.png",
          fit: BoxFit.cover,
        ));
  }

  Widget _logo() {
    return Container(
      width: double.infinity,
      child: SvgPicture.asset(
        'assets/images/sunset_logo.svg',
        semanticsLabel: 'Acme Logo',
        color: Colors.white,
      ),
    );
  }

  Widget _codigosQR(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 100.0),
        child: Column(
          children: <Widget>[
            QRCode(
              code: _qr,
              showText: true,
            ),
            _btnNuevoCodigo(context)
          ],
        ));
  }

  Widget _btnNuevoCodigo(BuildContext context) {
    return Container(
      width: 120.0,
      margin: EdgeInsets.symmetric(vertical: 14.0),
      child: RaisedButton(
          child: Text("Nuevo Codigo"),
          shape: StadiumBorder(),
          color: Color.fromRGBO(255, 255, 255, 0.5),
          elevation: 12.0,
          onPressed: () {

            Navigator.pushNamed(context, 'nuevoCodigo');
            
          }),
    );
  }



}
