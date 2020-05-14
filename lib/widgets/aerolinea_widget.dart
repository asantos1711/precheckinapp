import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/aerolinea_model.dart';

import 'package:precheckin/providers/aerolinea_provider.dart';
import 'package:precheckin/models/aerolineas_model.dart';

class AerolineaWidget extends StatelessWidget {
  AerolineaProvider _provider = new AerolineaProvider();
  List<Aerolinea> _aeroLineas = [];
  String valorInicial;
  final Function change;

  AerolineaWidget({
    this.valorInicial,
    this.change
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _provider.getAerolineas(),
      builder: (BuildContext context, AsyncSnapshot<AerolineasModel> snapshot) {

        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        
        _aeroLineas = snapshot.data.aerolineas;
        valorInicial = _verificarValorInicial(valorInicial);

        return DropdownButton(
          isExpanded: true,
          items: _getItems(),
          value: valorInicial.trim(),
          onChanged: change,
        );
      },
    );
  }

  //Forma la lista de los items apartir de la lista de paises obtenida del provider
  List<DropdownMenuItem<String>> _getItems() {
    List<DropdownMenuItem<String>> lista = new List();

    _aeroLineas.forEach( (ar) {
      lista.add(DropdownMenuItem(
        child: Text(ar.name),
        value: ar.fs,
      ));
    });

    return lista;
  }


  //Valida que la clve de estado que biene en valor inicial este entre los que trar e
  //servicio de estadps.
  String _verificarValorInicial(String val){
    String e = "-";
    
    for (var i = 0; i < _aeroLineas.length; i++) {
      if(val == _aeroLineas[i].fs) {
        e = val;
        break;
      }
    }

    return e;
  }

}