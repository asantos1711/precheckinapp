import 'package:flutter/material.dart';

import 'package:precheckin/providers/idiomas_provider.dart';
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/tools/application.dart';

///Widget Idiomas
///
///Este widget retorna un SingleChildScrollView
///con desplazamiento horizontal con todos los
///idiomos que bienen del Future cargarIdiomas.
class Idimonas extends StatelessWidget {
  QRPersistence _persitence = new QRPersistence();
  List<dynamic> _idiomas;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: idiomasProvider.cargarIdiomas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState != ConnectionState.done)
          return Center(child: CircularProgressIndicator(),);

        _idiomas = snapshot.data;
        
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _listaIdiomas(context),
          )
        );
      },
    );
  }

  List<Widget> _listaIdiomas(BuildContext context){
    List<Widget> widgets = [];

    _idiomas.forEach( (idioma){
      Widget widget = InkWell(
        splashColor: Colors.blue.withAlpha(70),
        child: Container(
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle
          ),
          child: Image.asset(idioma['img']),
        ),
        onTap: (){
          applic.onLocaleChanged(new Locale(idioma['languageCode'], idioma['countryCode']));
          
          //_persitence.qr = ["MC0yMTE0NjA1","MC0yMTE0NjA3","MC0yMTE0NjAz", "MC0yMTE0NjA0"];

          if(_persitence.qr.isNotEmpty){
             if(_persitence.qr.length == 1)
              Navigator.pushNamed(context, "verQR", arguments: _persitence.qr[0]);
             else
              Navigator.pushNamed(context, 'codigosQR', arguments: _persitence.qr);
          }
          else
            Navigator.pushNamed(context, 'nuevoCodigo');
        },
      );
      widgets.add(widget);
    } );

    return widgets;
  }
}