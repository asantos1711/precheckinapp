import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/result_model.dart';

import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/preferences/user_preferences.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/blocs/pms_bloc.dart';

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
  PMSBloc _pmsBloc;

  @override
  void initState() {
    super.initState();

    _qr      = _persistence.qr;
    _pmsBloc = new PMSBloc();
    _model   = _pmsBloc.reserva;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Container(
        width: MediaQuery.of(context).size.width/2,
          child: AutoSizeText(
            Translations.of(context).text('reservation_list'),
            style: appbarTitle,
            maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 5.0 ,
          )
        )
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
    _enableButton = _pref.reservasProcesadas.contains(_model.result.idReserva.toString());

    _model.ligadas.forEach((r) { 
      if(_enableButton == false)
        _enableButton = _pref.reservasProcesadas.contains(r.idReserva.toString());

      widgets.add( _reserva(context, r) );
    });

    widgets.add(_buttonFinalizar(context));

    return widgets;
  }

  Widget _reserva(BuildContext context, Result res) {
    bool procesado = _pref.reservasProcesadas.contains(res.idReserva.toString());

    return Container(
      margin: EdgeInsets.symmetric(horizontal:10.0, vertical:10.0),
      padding: EdgeInsets.all(10.0),
      decoration: procesado ? boxReservationProcessed : boxReservationUnprocessed,
      child: ListTile(
        leading: Icon(Icons.hotel),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_model.nombreHotel,style: greyText.copyWith(color: Colors.black),),
            Text(res.nombreTitular ?? "",style: greyText.copyWith(color: Colors.black)),
            Text("No. ${res?.idReserva}",style: greyText.copyWith(color: Colors.black)),
          ],
        ),
        trailing: procesado ? iconChecked : null,
        onTap: (){
          _pmsBloc.result = res;
          Navigator.pushNamed(context, 'infoTitular');
        },
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
          style: greyText.copyWith(
            color: _enableButton == false ? Colors.black : Colors.white,
            fontSize: 20.0),
        ),
      ));
  }
}