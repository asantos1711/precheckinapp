import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/result_model.dart';

import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/pages/HabitacionTitular.dart';
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/preferences/user_preferences.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';

class ListaReservas extends StatefulWidget {
  @override
  _ListaReservasState createState() => _ListaReservasState();
}

class _ListaReservasState extends State<ListaReservas> {
  

  QRPersistence _persistence = new QRPersistence();
  UserPreferences _pref = new UserPreferences();
  Reserva _model;
  bool _enableButton = false;
  List<String> _qr;

  @override
  void initState() {
    super.initState();

    _qr = _persistence.qr;
  }

  @override
  Widget build(BuildContext context) {
    _model = ModalRoute.of(context).settings.arguments;

    print(_pref.ligadas);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text(Translations.of(context).text('reservation_list')),
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

    if(widgets.length > _pref.ligadas.length)
      _enableButton = true;

    widgets.add(_buttonFinalizar(context));


    return widgets;
  }

  Widget _reserva(BuildContext context, Result res) {
    bool procesado = _pref.ligadas.indexOf(res.idReserva.toString()) == -1;

    return Container(
      margin: EdgeInsets.symmetric(horizontal:10.0, vertical:10.0),
      padding: EdgeInsets.all(10.0),
      decoration: procesado ? boxReservationProcessed : boxReservationUnprocessed,
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
        trailing: procesado ? iconChecked : null,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HabitacionTitular(reserva: _model, result: res,))),
      ),
    );
  }

  Widget _buttonFinalizar(BuildContext context) {
    return Container(
      width: double.infinity - 20,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 38),
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        splashColor: Colors.grey,
        onPressed: _enableButton == false ? null : (){
          if(!_qr.contains(_model.codigo))
            _qr.add(_model.codigo);

          _persistence.qr = _qr;

          Navigator.pushNamed(context, "verQR", arguments: _model.codigo);
        },
        child: Text(
          Translations.of(context).text('finalizar'),
          style: TextStyle(fontSize: 20.0),
        ),
      ));
  }
}