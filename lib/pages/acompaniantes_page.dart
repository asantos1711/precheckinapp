
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/pages/InformacionAdicional.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/utils/tools_util.dart' as tools;
import 'package:precheckin/widgets/card_acompanante.dart';
import 'package:precheckin/widgets/custom_signature.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:signature/signature.dart';

class AcompaniantesPage extends StatefulWidget {
  Reserva reserva;
  Result result;

  AcompaniantesPage({
    @required this.reserva,
    @required this.result
  });

  @override
  _AcompaniantesPageState createState() => _AcompaniantesPageState();

}

class _AcompaniantesPageState extends State<AcompaniantesPage> {
  Reserva _reserva;
  Result _result;
  int _maxAdutos;
  int _maxMenores;
  Acompaniantes _acompaniante;
  SignatureController _sigController;
  List<Acompaniantes> _listaAcompaniantes;

  @override
  void initState() {
    super.initState();

    _reserva            = widget.reserva;
    _result             = widget.result;
    _maxAdutos          = _result.tipoHabitacion.maxAdultos - _result.numeroAdultos;
    _maxMenores         = _result.tipoHabitacion.maxMenores - _result.getTotalMenores();
    _listaAcompaniantes = _result.acompaniantes;

    _acompaniante                 = new Acompaniantes();
    _acompaniante.fechanac        = new DateTime.now().toString();
    _acompaniante.club            = _result.idClub;
    _acompaniante.idcliente       = _result.idCliente;
    _acompaniante.idacompaniantes = 0;
    _acompaniante.istitular       = false;

    _sigController = new SignatureController();
    _sigController.addListener(() async {
        var data = await _sigController.toPngBytes();
        _acompaniante.imagesign = base64.encode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).text('add_companion')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              _instruccion(),
              _firma(),
              _cargoExtra(),
              _buttonContinuar(),
            ],
          ),
      ),
    );
  }


  Widget _instruccion(){
    Text titulo = Text(Translations.of(context).text('room_capacity'), style: titulos,);
    Widget adultos = Container();
    Widget menores = Container();

    if(_maxAdutos > 0)
      adultos = RichText(
        text: TextSpan(
          children: [
            TextSpan(text: _maxAdutos.toString(), style: titulos,),
            TextSpan(text: Translations.of(context).text("adult_more"), style: valor,),
          ]
        ),
      );

    if(_maxMenores > 0)
      menores = RichText(
        text: TextSpan(
          children: [
            TextSpan(text: _maxMenores.toString(), style: titulos,),
            TextSpan(text: Translations.of(context).text("minor_more"), style: valor,),
          ]
        ),
      );

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration:boxReservationProcessed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titulo,
          SizedBox(height: 10.0,),
          adultos,
          SizedBox(height: 10.0,),
          menores
        ],
      ),
    );
  }




  Widget _firma(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal:10.0,vertical: 0.0),
      padding: EdgeInsets.all(5.0),
      child: CardAcompanante(
        acompaniante: _acompaniante,
        adultos: (_maxAdutos > 0) ? true : false,
        menores: ( _maxMenores > 0) ? true : false,
        nuevo: true,
        signature: CustomSignature(
          controller: _sigController,
        ),
      ),
    );
  }

  Widget _cargoExtra() {
    String cargo = Translations.of(context).text('cargo');

    return ListTile(
      leading: Icon(FontAwesomeIcons.exclamationCircle , color: Colors.red, size: 15),
      title: Text(cargo, style: TextStyle(color: Colors.red, fontSize: 15),),
    );
  }



  Widget  _buttonContinuar(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
      color: Colors.white,
      child:FlatButton(
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.orange,
        onPressed: (){
          if(_acompaniante.nombre.isEmpty || _acompaniante.edad.isEmpty)
            tools.showAlert(context, Translations.of(context).text("name_age_invalid"));
          else
            _saveData();
        },
        child: Text(
          Translations.of(context).text('continuar'),
          style: TextStyle(fontSize: 20.0, fontFamily: "Montserrat"),
        ),
      )
    );
  }


  void _saveData(){
    int edad = int.parse(_acompaniante.edad);
    if(edad >= 18)
      _result.numeroAdultos = _result.numeroAdultos + 1;
    
    if(edad >= 12 && edad < 18)
      _result.numeroAdolecentes = _result.numeroAdolecentes + 1;
    
    if(edad < 12)
      _result.numeroNinios = _result.numeroNinios + 1;


    _listaAcompaniantes.add(_acompaniante);
    _result.acompaniantes = _listaAcompaniantes;

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => InformacionAdicional(reserva: _reserva, result: _result,)));
  }
}