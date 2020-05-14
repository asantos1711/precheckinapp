import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/result_model.dart';

import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/pages/HabitacionTitular.dart';

class ListaReservas extends StatelessWidget {
  Reserva _model;

  @override
  Widget build(BuildContext context) {
    _model = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text("lista de reservas"),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: _reservas(context),
        ),
      ),
    );
  }



  List<Widget> _reservas(BuildContext context){
    List<Widget> widgets = [ _reserva(context, _model.result) ];

    _model.ligadas.forEach((r) { 
      widgets.add( _reserva(context, r) );
    });

    return widgets;
  }

  Widget _reserva(BuildContext context, Result res) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal:10.0, vertical:10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color.fromRGBO(0, 0, 0, 0.09)
      ),
      child: ListTile(
        leading: Icon(Icons.hotel),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_model.nombreHotel),
            Text(res.nombreTitular ?? ""),
            Text("No. ${res?.idReserva}"),
          ],
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HabitacionTitular(reserva: _model, result: res,))),
      ),
    );
  }
}