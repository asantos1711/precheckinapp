import 'package:flutter/material.dart';

import 'package:precheckin/providers/aerolinea_provider.dart';
import 'package:precheckin/search/aerolineas_search.dart';
import 'package:precheckin/models/aerolineas_model.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';


class AerolineasWidget extends StatefulWidget {
  Function onTap;
  String valorInicial;

  AerolineasWidget({ @required this.onTap, this.valorInicial = "" });

  @override
  _AerolineasWidgetState createState() => _AerolineasWidgetState();
}


class _AerolineasWidgetState extends State<AerolineasWidget>{
  String _titulo;
  TextEditingController _ctrlAeroliner;
  AerolineaProvider _provider;
  List<Aerolinea> _aeroLineas;
  String _valor = "";


  @override
  void initState() {
    super.initState();
    _ctrlAeroliner   = new TextEditingController();
    _provider        = new AerolineaProvider();
    _aeroLineas      = [];

   
  }


  @override
  Widget build(BuildContext context) {
    _titulo = Translations.of(context).text('aerolinea');

    return FutureBuilder(
      future: _provider.getAerolineas(),
      builder: (BuildContext context, AsyncSnapshot<AerolineasModel> snapshot) {

        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        
        _aeroLineas = snapshot.data.aerolineas;
        _valor = _getValorInicial();
        _ctrlAeroliner.text = _valor;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_titulo, style: greyText,),
            TextField(
              controller: _ctrlAeroliner,
              style: greyText.copyWith(fontWeight: FontWeight.bold),
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                Aerolinea aerolinea = await showSearch(context: context, delegate: AerolineasSearch(aeroLineas: _aeroLineas), query: _valor);

                _ctrlAeroliner.text = aerolinea?.name;

                widget.onTap.call(aerolinea?.fs);
              },
            )
          ],
        );
      },
    );
  }


  //Establecer el valor inicial
  String _getValorInicial(){
    String valor = "";
    List<Aerolinea> list = _aeroLineas.where( (a)=>a.fs.toLowerCase() == widget.valorInicial.toLowerCase()).toList();

    if(list.length > 0)
      valor = list[0]?.name;

    return valor;
  }
}