import 'package:flutter/material.dart';
import 'package:precheckin/tools/translation.dart';

import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/utils/hotel_utils.dart' as util_hotel;

class HotelMixin{

  Widget infoReserva(BuildContext context, Reserva reserva, Result result){
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(color: backgroundBloqueado),
      child: Column(
        children: <Widget>[
          _infoHotel(reserva),
          _infoReservacion(context, result),
          _llegadaSalida(context, result),
          _huespedes(context, result),
          _tipoHabitacion(context, result),
          _planViaje(context, reserva, result),
          _requeEspeciales(context, reserva),
        ]
      ),
    );
  }

  Widget _infoHotel(Reserva reserva){
    return Container(
      decoration: boxDecorationDefault,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Hotel',style: greyText.copyWith(fontWeight: FontWeight.w200)),
          SizedBox(height: 5,),
          Text( reserva.nombreHotel, style: valor ),
          SizedBox(height: 5,)
        ],
      )
    );
  }

  Widget _infoReservacion(BuildContext context, Result result){
    return Container(
      width: double.infinity,
      decoration: boxDecorationDefault,
      margin: EdgeInsets.only(top:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(Translations.of(context).text('no_reserva'),style: greyText.copyWith(fontWeight: FontWeight.w200)),
          SizedBox(height: 5.0),
          Text(result.idReserva.toString(),style: valor),
          SizedBox(height: 5.0)
        ],
      )
    );
  }

 Widget _llegadaSalida(BuildContext context, Result result){
    return Container(
      width: double.infinity,
      decoration: boxDecorationDefault,
      margin: EdgeInsets.only(top:10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(Translations.of(context).text('llegada'),style: greyText.copyWith(fontWeight: FontWeight.w200)),
              SizedBox(height: 5.0),
              Text(result.fechaCheckin, style: valor,),
              SizedBox(height: 5.0)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(Translations.of(context).text('salida'),style: greyText.copyWith(fontWeight: FontWeight.w200)),
              SizedBox(height: 5.0),
              Text(result.fechaCheckout, style: valor,),
              SizedBox(height: 5.0)
            ],
          ),
        ],
      )
    );
  }

  Widget _huespedes(BuildContext context, Result result){
    return Container(
      width: double.infinity,
      decoration: boxDecorationDefault,
      margin: EdgeInsets.only(top:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(Translations.of(context).text('huespedes'),style: greyText.copyWith(fontWeight: FontWeight.w200)),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('${result.numeroAdultos} '+Translations.of(context).text('adultos'),style: valor,),
                  Text(Translations.of(context).text('adultos_edad'),style: valor,)
                ],
              ),
              
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${result.numeroAdolecentes} '+Translations.of(context).text('adolecentes'),style: valor,),
                  Text(Translations.of(context).text('adolecentes_edad'),style: valor,)
                ],
              ),
              
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('${result.numeroNinios} '+Translations.of(context).text('ninos'),style: valor),
                  Text(Translations.of(context).text('ninos_edad'),style: valor)
                ],
              ),
            ],
          ),
          SizedBox(height: 5.0),
        ]
      )
    );
  }

  Widget _tipoHabitacion(BuildContext context, Result result){
    return Container(
      width: double.infinity,
      decoration: boxDecorationDefault,
      margin: EdgeInsets.only(top:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(Translations.of(context).text('tipo_habitacion'),style: greyText.copyWith(fontWeight: FontWeight.w200)),
          SizedBox(height: 5,),
          Text(result.tipoHabitacion?.descripcion ?? '', style: valor),
          SizedBox(height: 5,)
        ],
      )
    );
  }
  
  Widget _planViaje(BuildContext context, Reserva reserva, Result result){
    return Container(
      width: double.infinity,
      decoration: boxDecorationDefault,
      margin: EdgeInsets.only(top:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(Translations.of(context).text('plan_viaje'),style: greyText.copyWith(fontWeight: FontWeight.w200)),
          SizedBox(height: 5.0),
          Text(util_hotel.getClavePlan(result.idClub.toString(), reserva.plana),style: valor),
          SizedBox(height: 5.0)
        ],
      )
    );
  }
  
  Widget _requeEspeciales(BuildContext context, Reserva reserva){
    return Container(
      width: double.infinity,
      decoration: boxDecorationDefault,
      margin: EdgeInsets.only(top:10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _listaEspecialRequest(context, reserva),
      )
    );
  }

  List<Widget> _listaEspecialRequest(BuildContext context, Reserva reserva) {
    List<Widget> widgets = [];

    widgets..add(Text(Translations.of(context).text('reque_especiales'),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16)))
            ..add(SizedBox(height: 10.0));

    reserva.especialRequest.forEach( (r){
      Widget widget = Text("${r.subcategoria}*");

      widgets..add(widget)
              ..add(SizedBox(height: 10.0));
    });

    widgets.add(
      Container(
        width: double.infinity,
        child: Text(Translations.of(context).text('sujeto_dispo'),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16), textAlign: TextAlign.end)
      )
            
    );

    return widgets;
  }
}