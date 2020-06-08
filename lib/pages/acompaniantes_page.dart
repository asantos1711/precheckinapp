import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/blocs/pms_bloc.dart';

import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/utils/tools_util.dart' as tools;
import 'package:precheckin/widgets/btn_encuesta_salud_widget.dart';
import 'package:precheckin/widgets/card_acompanante.dart';
import 'package:precheckin/widgets/custom_signature.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:signature/signature.dart';

class AcompaniantesPage extends StatefulWidget {
  @override
  _AcompaniantesPageState createState() => _AcompaniantesPageState();

}

class _AcompaniantesPageState extends State<AcompaniantesPage> {
  PMSBloc _pmsBloc;
  int _totalAdultos;
  int _totalMenores;
  int _maxAdultos;
  int _maxMenores;
  Acompaniantes _acompaniante;
  SignatureController _sigController;

  @override
  void initState() {
    super.initState();

    _pmsBloc      = new PMSBloc();    
    _totalAdultos = _pmsBloc.totalAdoultos;
    _totalMenores = _pmsBloc.totalMenores;
    _maxAdultos   = _totalAdultos + ((_totalMenores > 0) ? _totalMenores ~/ 2 : 0);
    _maxMenores   = _totalMenores + _totalAdultos;

    
    _acompaniante                 = new Acompaniantes();
    _acompaniante.fechanac        = new DateTime.now().toString();
    _acompaniante.edad            = '0';
    _acompaniante.club            = int.parse(_pmsBloc.idHotel);
    _acompaniante.idcliente       = _pmsBloc.idCliente;
    _acompaniante.idacompaniantes = 0;
    _acompaniante.istitular       = false;

    _sigController = new SignatureController();
    _sigController.addListener(() async {
        var data = await _sigController.toPngBytes();
        if(data != null)
          _acompaniante.imagesign = base64.encode(data);
    });
    _pmsBloc.posRoute=3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Translations.of(context).text('add_companion')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              _infoDensidad(),
              _firma(),
              _cargoExtra(),
              _buttonContinuar(),
            ],
          ),
      ),
    );
  }

  /**
   * Muestra la información de la densidad de la habitación,
   * y los botones para convertir de adulos a niños y viceversa
   * si la densidad lo permite.
   */
  Widget _infoDensidad(){
    Text titulo = Text(Translations.of(context).text('room_capacity'), style: titulos,);

    TextSpan totalAdultos    = new TextSpan(text: '');
    TextSpan etiquetaAdulos  = new TextSpan(text: '');
    TextSpan totalMenores    = new TextSpan(text: '');
    TextSpan etiquetaMenores = new TextSpan(text: '');
    TextSpan or              = TextSpan(text:'');

    if(_maxAdultos > 0){
      totalAdultos    = new TextSpan(text: _maxAdultos.toString(),style: titulos);
      etiquetaAdulos  = new TextSpan(text: Translations.of(context).text("adult_more"), style: valor);
    }

    if(_maxMenores > 0){
      totalMenores    = new TextSpan(text: _maxMenores.toString(),style: titulos);
      etiquetaMenores = TextSpan(text: Translations.of(context).text("minor_more"), style: valor);
    }

    if(_maxAdultos > 0 && _maxMenores >0 )
      or = TextSpan(text: " ${Translations.of(context).text('or')} ", style: valor);


    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration:boxInfoDensidad,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titulo,
          SizedBox(height: 10.0,),
          RichText(
            text: TextSpan(
              children: [
                totalAdultos,
                etiquetaAdulos,
                or,
                totalMenores,
                etiquetaMenores,
              ]
            ),
          )
        ],
      ),
    );
  }


  /**
   * Muestr el Widget de captura de información
   * del nuevo acompañante.
   */
  Widget _firma(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      child: CardAcompanante(
        acompaniante: _acompaniante,
        adultos: !(_maxAdultos > 0),
        menores: !( _maxMenores > 0),
        nuevo: true,
        //btnEncuesta: _buttonEncuentaCovid(),
        signature: CustomSignature(
          controller: _sigController,
        ),
      ),
    );
  }

  /**
   * Para agregar el botón de acompañantes
   */
  Widget  _buttonEncuentaCovid() => Center(
    child: BtnEncuestaSalud(
      pmsBloc: _pmsBloc,
      posicion: -2,
    ),
  );

  /**
   * Muestr la leyenda que informa del
   * cargo extra por agregar acompñante.
   */
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

    if(edad >= 18) {
      _pmsBloc.incrementarAdultos = 1;

      if(_totalAdultos <= 0)
        _pmsBloc.incrementarMenoresEquivalencia = 2;
    } else if(edad >= 12 && edad < 18){
      _pmsBloc.incrementarAdolecentes = 1;

      if(_totalMenores <= 0)
        _pmsBloc.incrementarAdultosEquivalencia = 1;
    } else if(edad < 12){
      _pmsBloc.incrementarNinios = 1;

      if(_totalMenores <= 0)
        _pmsBloc.incrementarAdultosEquivalencia = 1;
    }
     
    _pmsBloc.addAcompaniante = _acompaniante;

    Navigator.pushReplacementNamed(context, 'infoAdicional');
  }
}