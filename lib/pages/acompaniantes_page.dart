
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
  int _maxAdultos;
  int _maxMenores;
  Acompaniantes _acompaniante;
  SignatureController _sigController;
  List<Acompaniantes> _listaAcompaniantes;
  Size _size;
  double _width;
  bool _verIncrementarAdultosBtn = true;
  bool _verIncrementarMenoresBtn = true;

  @override
  void initState() {
    super.initState();

    _reserva            = widget.reserva;
    _result             = widget.result;
    _maxAdultos         = _result.tipoHabitacion.maxAdultos - _result.getTotalAdultos();
    _maxMenores         = _result.tipoHabitacion.maxMenores - _result.getTotalMenores();
    _maxAdultos         = (_maxAdultos < 0) ? 0 : _maxAdultos;
    _maxMenores         = (_maxMenores < 0) ? 0 : _maxMenores;
    _listaAcompaniantes = _result.acompaniantes;

    _acompaniante                 = new Acompaniantes();
    _acompaniante.fechanac        = new DateTime.now().toString();
    _acompaniante.edad            = '0';
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
    _size   = MediaQuery.of(context).size;
    _width  = _size.width;

    return Scaffold(
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
    Widget adultos = _adultos();
    Widget menores = _menores();

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
          adultos,
          menores,
        ],
      ),
    );
  }


  /** 
   * Mostrar la etiqueda de los adutos
   * y el boton para incrementar el número
   * de adutos si la densidad de la
   * habitación lo permita
   */
  Widget _adultos(){
    Widget adultos = Container();
    Widget incrementar = Container();

    //Condición para mostrar el botón de incrementar adultos.
    if(_maxAdultos <= 0 &&_maxMenores >= 2 && _verIncrementarAdultosBtn == true && _verIncrementarMenoresBtn == true)
      incrementar = IconButton(
        icon: Icon(Icons.add_circle_outline, color:Colors.green),
        splashColor: Colors.white,
        onPressed: () async {
          if(await tools.confimarAccion(context, Translations.of(context).text('add_adult_alert'))){
            setState(() {
              _maxAdultos++;
              _maxMenores = _maxMenores-2;
              _verIncrementarAdultosBtn = false;
            });
          }
        },
      );

    //Mostrar el botón de cancelar acción de incrementar adultos
    if(_verIncrementarAdultosBtn == false)
      incrementar = IconButton(
        icon: Icon(Icons.replay, color: Colors.red,),
        splashColor: Colors.white,
        onPressed: (){
          setState(() {
            _maxAdultos--;
            _maxMenores = _maxMenores + 2;
            _verIncrementarAdultosBtn = true;
          });
        },
      );

    if(_maxAdultos > 0 || _maxMenores >= 2) {
      adultos = Container(
        height: 35.0,
        width: _width*0.5,
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: _maxAdultos.toString(), style: titulos,),
                  TextSpan(text: Translations.of(context).text("adult_more"), style: valor,),
                ]
              ),
            ),
            Expanded(child: Container(),),
            incrementar
          ],
        ),
      );
    }

    return adultos;
  }


  /** 
   * Mostrar la etiqueda de los adutos
   * y el boton para incrementar el número
   * de adutos si la densidad de la
   * habitación lo permita
  */
  Widget _menores(){
    Widget menores = Container();
    Widget incrementar = Container();

    if(_maxMenores <=0 && _maxAdultos > 0 && _verIncrementarMenoresBtn == true &&  _verIncrementarAdultosBtn == true)
      incrementar = IconButton(
        icon: Icon(Icons.add_circle_outline, color:Colors.blue),
        splashColor: Colors.white,
        onPressed: () async {
          if(await tools.confimarAccion(context, Translations.of(context).text('add_minor_alert'))){
            setState(() {
              _maxMenores++;
              _maxAdultos--;
              _verIncrementarMenoresBtn = false;
            });
          }
        },
      );

    //Mostrar el botón de cancelar acción de incrementar menores
    if(_verIncrementarMenoresBtn == false)
      incrementar = IconButton(
        icon: Icon(Icons.replay, color: Colors.red,),
        splashColor: Colors.white,
        onPressed: (){
          setState(() {
            _maxMenores--;
            _maxAdultos++;
            _verIncrementarMenoresBtn = true;
          });
        },
      );


    if(_maxAdultos > 0 || _maxMenores > 0)
      menores = Container(
        height: 35.0,
        width: _width * 0.5,
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: _maxMenores.toString(), style: titulos,),
                  TextSpan(text: Translations.of(context).text("minor_more"), style: valor,),
                ]
              ),
            ),
            Expanded(child: Container(),),
            incrementar
          ],
        ),
      );

    return menores;
  }



  /**
   * Muestr el Widget de captura de información
   * del nuevo acompañante.
   */
  Widget _firma(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal:10.0,vertical: 0.0),
      padding: EdgeInsets.all(5.0),
      child: CardAcompanante(
        acompaniante: _acompaniante,
        adultos: (_maxAdultos > 0) ? true : false,
        menores: ( _maxMenores > 0) ? true : false,
        nuevo: true,
        equivalenciaAdultos: !_verIncrementarAdultosBtn,
        equivalenciaMenores: !_verIncrementarMenoresBtn,
        signature: CustomSignature(
          controller: _sigController,
        ),
      ),
    );
  }


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


    print("Age: ${edad}");
    print("Incrementar Adultos: ${!_verIncrementarAdultosBtn}");
    print("Incrementar Menores: ${!_verIncrementarMenoresBtn}");

    //return;

    if(edad >= 18){
      _result.numeroAdultos = _result.numeroAdultos + 1;
      
      if(!_verIncrementarAdultosBtn)
        _result.menoresPorEquivalencia = _result.menoresPorEquivalencia + 2;
    }
    
    if(edad >= 12 && edad < 18){
      _result.numeroAdolecentes = _result.numeroAdolecentes + 1;

      if(!_verIncrementarMenoresBtn)
        _result.adultosPorEquivalencia = _result.adultosPorEquivalencia + 1;
    }
    
    if(edad < 12){
        _result.numeroNinios = _result.numeroNinios + 1;

      if(!_verIncrementarMenoresBtn)
        _result.adultosPorEquivalencia = _result.adultosPorEquivalencia + 1;

    }

    _acompaniante.agregadoPorEquivalencia = (!_verIncrementarAdultosBtn || !_verIncrementarMenoresBtn) ? true : false;

    _listaAcompaniantes.add(_acompaniante);
    _result.acompaniantes = _listaAcompaniantes;

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => InformacionAdicional(reserva: _reserva, result: _result,)));
  }

}