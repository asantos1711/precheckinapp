import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return Image.asset(
      "assets/images/background.png",
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }

  Widget _contenido(){
    return ListView(
        children: <Widget>[
          _logo(),
          _codigosQR(),
          _btnNuevoCodigo()
        ],
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
      child: Column(
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
      color: Color.fromRGBO(255, 255, 255, 0.5),
      child: RaisedButton(
        child: Text("Nuevo Codigo"),
        onPressed:(){

          print("PRES");

        },
      ),
    );
  }

}