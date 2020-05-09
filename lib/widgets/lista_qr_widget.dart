import 'package:flutter/material.dart';
import 'package:precheckin/providers/qr_provider.dart';
import 'package:precheckin/tools/translation.dart';


///Widget ListaQR
///
///Genera una lista de ListTitle por cada uno de los
///codigos qr almacenados en el dispocitivo y que son
///validados por el PMS
class ListaQR extends StatelessWidget {
  
  List<dynamic> _listaQR;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: qrProvider.validarCodigos(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.connectionState != ConnectionState.done)
          return Center(child: CircularProgressIndicator());

        _listaQR = snapshot.data;

        if(_listaQR.isEmpty)
          return _sinCodigos();
        
        return ListView(
          children: _listaCodigos(context),
        );
      },
    );
  }


  //Genera la lista de códigos a mostrar
  List<Widget> _listaCodigos(BuildContext context){
    List<Widget> widgets= [];

    _listaQR.forEach( (qr){
      Widget widget = Container(
        margin: EdgeInsets.symmetric(horizontal:10.0, vertical:10.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: Icon(Icons.blur_linear),
          title: Text(qr['hotel']),
          subtitle: Text(qr['titular']),
          trailing: Column(
            children: <Widget>[
              Text( Translations.of(context).text('habitacion') ),
              Text(qr['cuarto'],style: TextStyle(fontSize: 30.0),),
            ],
          ),
          onTap: () => Navigator.pushNamed(context, "verQR", arguments: qr['codigo'])
        ),
      );

      widgets.add(widget);
    } );

    return widgets;
  }

  //Mensaje que se muestra cuendo no se encuentran códigos a mostrar
  Widget _sinCodigos() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical:14.0),
      padding: EdgeInsets.symmetric(vertical:20.0),
      child: Center(
        child: ListTile(
          leading: Icon(Icons.warning),
          title: Text("Favor de capturar codigo"),
        ),
      ),
    );
  }
}