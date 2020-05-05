import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheckin/tools/translation.dart';

class ListaCodigosQR extends StatefulWidget {
  @override
  _ListaCodigosQRState createState() => _ListaCodigosQRState();
}

class _ListaCodigosQRState extends State<ListaCodigosQR> {
  List<String> _codigos;

  @override
  Widget build(BuildContext context) {
     _codigos = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _imagenFondo(),
          _contenido(),
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


  Widget _contenido(){
    return SafeArea(
      child: Column(
        children: <Widget>[
          _logo(),
          //_codigosQR(),
          Expanded(child: _codigosQR(),),
          _btnNuevoCodigo()
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


  Widget _codigosQR(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical:10.0),
      child: ListView(
        children: _listaCodigos(),
      ),
    );
  }

  List<Widget> _listaCodigos(){
    List<Widget> widgets= [];

    _codigos.forEach( (codigo){
      Widget widget = Container(
        margin: EdgeInsets.symmetric(horizontal:10.0, vertical:10.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.5),
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: ListTile(
          leading: Icon(Icons.blur_linear),
          title: Text(codigo),
          onTap: (){
            print("TAP");
          },
        ),
      );

      widgets.add(widget);
    } );

    return widgets;
  }

  Widget _btnNuevoCodigo(){
    return Container(
      width: 120.0,
      margin: EdgeInsets.symmetric(vertical:14.0),
      child: RaisedButton(
        child: Text( Translations.of(context).text('btn_new_code') ), 
        onPressed:(){

          Navigator.pushNamed(context, "serCodigo");

        },
      ),
    );
  }

}