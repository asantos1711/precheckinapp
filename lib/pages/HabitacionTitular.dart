import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/pages/InformacionAdicional.dart';
import 'package:precheckin/pages/mixins/hotel_mixin.dart';
import 'package:precheckin/styles/styles.dart';

import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/utils/fecha_util.dart' as futil;
import 'package:precheckin/widgets/aerolinea_widget.dart';
import 'package:precheckin/widgets/paises_widget.dart';
import 'package:precheckin/widgets/estados_widget.dart';

class HabitacionTitular extends StatefulWidget {
  Reserva reserva;
  Result result;

  HabitacionTitular({
    @required this.reserva,
    @required this.result,
  });


  @override
  _HabitacionTitularState createState() => _HabitacionTitularState();
}

class _HabitacionTitularState extends State<HabitacionTitular> with TickerProviderStateMixin, HotelMixin{

  Reserva _reserva;  
  Result _result;
  String _pais;
  String _estado;
  String _aerolinea;
  double height;
  double width;
  double space;
  DateTime _fechaVuelo;
  TextEditingController _controllerNombre;
  TextEditingController _controllerCiudad;
  TextEditingController _controllerCP;
  TextEditingController _controllerAerolinea;
  TextEditingController _controllerFechaVuelo;
  TextEditingController _controllerVuelo;



  AnimationController _controller;
  static const List<String> _funcionList = const [ "1","2" ];
  Map<String,String> _opcionesFloat = new  Map<String,String>();


  @override
  void initState() {
    super.initState();
   
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _reserva    = this.widget.reserva;  
    _result     = this.widget.result;

    _controllerNombre = new TextEditingController(text:_result.titular.nombre ?? "");
    _controllerCiudad = new TextEditingController(text: _result.titular.ciudad ?? "");
    _controllerCP     = new TextEditingController(text: _result.codigoPostal ?? "");

    _controllerAerolinea  = new TextEditingController(text: (_result.vuelos.isNotEmpty) ? (_result.vuelos[0].aerolinea1 ?? "") : "");
    _fechaVuelo           = _result.vuelos[0].fechasalida.isNotEmpty ? DateTime.parse(_result.vuelos[0].fechasalida) : DateTime.now();
    _controllerFechaVuelo = new TextEditingController(text: (_result.vuelos[0].fechasalida.isEmpty) 
                                  ? "${_fechaVuelo.day}/${_fechaVuelo.month}/${_fechaVuelo.year}" 
                                  : futil.splitFecha(_result.vuelos[0].fechasalida));
    _controllerVuelo      = new TextEditingController(text: _result.vuelos.isNotEmpty ?(_result.vuelos[0].vuelollegada ?? "") : "");

    if(_result.vuelos[0].fechallegada.isNotEmpty)
      _result.vuelos[0].fechallegada = futil.fechaISO8601fromString(_result.vuelos[0].fechallegada);
  }




  @override
  Widget build(BuildContext context) {
    _inicializarDatos();//Inicializa las variables.

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _floatButton(),
    );
  }


  void _inicializarDatos() {

    _pais                     = (_pais == null) ? _result.titular.pais : _pais; //Validacion para que cambie el valor del pais
    _estado                   = (_estado == null) ? _result.estado : _estado; //Validacion para que cambie el valor del estado
    _aerolinea                = (_aerolinea == null) ? (_result.vuelos.isNotEmpty ? (_result.vuelos[0].aerolinea1 ?? "") : "") ?? "" : _aerolinea;

    _opcionesFloat["1"]       = Translations.of(context).text('opcion_duda').toString();
    _opcionesFloat["2"]       = Translations.of(context).text('opcion_error').toString();
    height                    = MediaQuery.of(context).size.height;
    width                     = MediaQuery.of(context).size.width;
  }

  Widget _appBar(){
    return AppBar(
      leading: Container(),
      title:Container(
        width: MediaQuery.of(context).size.width/0.7,
          child: AutoSizeText(
            Translations.of(context).text('info_reservacion'),
            style: appbarTitle,
            maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 5.0 ,
          )
        ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return ListView(
      children: <Widget>[
        infoReserva(context, _reserva, _result),
        _seccionTitular(),
        _seccionContacto(),
        _seccionVuelo(),
        _buttonContinuar(),
      ],
    );
  }


  Widget _seccionTitular(){
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              decoration: boxDecorationDefault,
              width: double.infinity,
              child: Text(Translations.of(context).text('info_titular'), style:titulos),
            ),
          SizedBox(height: 5.0,),
          Container(
            decoration: boxDecorationDefault,
            width: double.infinity,
            child: TextFormField(
              controller: _controllerNombre,
              style: greyText.copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: Translations.of(context).text('nombre'),
                labelStyle: greyText.copyWith(fontWeight: FontWeight.w200),
              ),
              onChanged: (nombre){
                _result.nombreTitular = nombre;
                _result.titular.nombre = nombre;
              },
            )
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _dropdownPaises(),
                _dropdownEstado(),
                ],
            )
          ),
          SizedBox(height: 5,),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10),
                  width: (width-50)/2,
                  child: TextFormField(
                    controller: _controllerCiudad,
                    style: greyText.copyWith(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: Translations.of(context).text('ciudad'),
                      labelStyle: greyText.copyWith(fontWeight: FontWeight.w200),
                    ),
                    onChanged: (ciudad) {
                      _result.ciudad = ciudad;
                      _result.titular.ciudad = ciudad;
                    },
                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: (width-50)/2,
                  child: TextFormField(
                    controller: _controllerCP,
                    style: greyText.copyWith(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: Translations.of(context).text('cod_postal'),
                      labelStyle: greyText.copyWith(fontWeight: FontWeight.w200),
                    ),
                    onChanged: (cp){
                      _result.codigoPostal = cp;
                      _result.titular.codigoPostal = cp;
                    },
                  )
                )
              ],
            )
          ),
        ],
      )
    );
  }

  Widget _dropdownPaises(){
    return Container(
      width: (width-50)/2,
      padding: EdgeInsets.only(top: 5, right: 10),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translations.of(context).text('pais'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          PaisesWidget(
            hotel:"0",
            valorInicial: _pais ?? "MEX",
            change: (pais){
              setState(() {
                _pais = pais;
                _result.pais = pais;
                _result.titular.pais = pais;
              });
            },
          )
        ]
      ),
    );
  }

  Widget _dropdownEstado(){
    return Container(
      width: (width-50)/2,
      padding: EdgeInsets.only(top: 5, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translations.of(context).text('estado'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          EstadosWidget(
            hotel:"0",
            pais: _pais,
            valorInicial: _estado,
            change: (estado){
              setState(() {
                _estado = estado;
                _result.estado = estado;
                _result.titular.estado = estado;
              });
            },
          )
        ],
      ),
    );
  }
  
  Widget _seccionContacto(){
    return Container(
      margin: EdgeInsets.only( bottom: 5),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(color: backgroundBloqueado),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(bottom: 5, left:10),
              width: double.infinity,
              child: Text(Translations.of(context).text('info_contacto'),style: titulos,),
              decoration: boxDecorationDefault,
            ),
          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 7),
            width: (width-40),
            decoration: boxDecorationDefault,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      Translations.of(context).text('mail'),
                      style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                      )
                  ),
                ),
                SizedBox(height: 5,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(_result.email,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(height: 5,)
              ],
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 7),
            width: (width-40)/2,
            decoration:boxDecorationDefault,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      Translations.of(context).text('telefono'),
                      style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                      )
                  ),
                ),
                SizedBox(height: 5,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(_result.telefono,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 5,)
              ],
            )
          )
        ],
      )
    );
  }
  
  Widget _seccionVuelo(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical:10.0),
      child: Column(
        children: <Widget>[
          _infoVuelo(),
        ]
      ),
    );
  }


  Widget _infoVuelo(){
    
    return Container(
      padding: EdgeInsets.all(10),
      width: width,
      color: Colors.white,
      //decoration: _decoration(),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(bottom: 5, left:10),
              width: width-20,
              child: Text(
                Translations.of(context).text('agre_info_vuelo'),
                style: blueAcentText.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
              decoration: boxDecorationDefault,
            ),
          ),
          SizedBox(height: 5,),





          Container(
            padding: EdgeInsets.only(left: 10),
            width: width-30,
            child: AerolineasWidget(
              valorInicial: _controllerAerolinea.text,
              onTap: (value) {
                _controllerAerolinea.text    = value;
                _result.vuelos[0].aerolinea1 = value;
              },
            ),
          ),




          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 10),
                  width: (width-30)/2,
                  child: new Theme(
                      data: ThemeData(
                        primarySwatch: Colors.red,
                        primaryColor: Color.fromRGBO(191, 52, 26, 1),//Head background
                        accentColor: Color.fromRGBO(191, 52, 26, 1),
                        splashColor: Color.fromRGBO(191, 52, 26, 1),
                        primaryTextTheme: TextTheme(headline: greyText.copyWith(color: Color.fromRGBO(191, 52, 26, 1),fontWeight: FontWeight.bold)) ,
                        textTheme:TextTheme(headline:greyText.copyWith(color: Color.fromRGBO(191, 52, 26, 1),fontWeight: FontWeight.bold)) ,
                        accentTextTheme: TextTheme(headline:greyText.copyWith(color: Color.fromRGBO(191, 52, 26, 1),fontWeight: FontWeight.bold)) 
                      ),
                      child: new Builder(
                        builder: (context) =>new TextFormField(
                          controller: _controllerFechaVuelo,
                          decoration: InputDecoration(
                              labelText: Translations.of(context).text('fec_salida'),
                              labelStyle:  greyText.copyWith(fontWeight: FontWeight.w200),
                          ),
                          style: greyText.copyWith(fontWeight: FontWeight.bold),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                        ),
                      )
                    )
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: (width-30)/2,
                child: TextFormField(
                  controller: _controllerVuelo,
                  style: greyText.copyWith(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      labelText: Translations.of(context).text('no_vuelo'),
                      labelStyle: greyText.copyWith(fontWeight: FontWeight.w200)
                  ),
                  onChanged: (numeroVuelo){
                        _result.vuelos[0].vuelollegada = numeroVuelo;
                  },
                )
              )
            ],
          ),
        ],
      )
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime firstDate = new DateTime.now();
    DateTime lastDate = new DateTime((firstDate.year + 50), firstDate.month, firstDate.day);


    final DateTime picked = await showDatePicker(
      context: context,
      locale: Translations.of(context).locale,
      initialDate: _fechaVuelo,
      firstDate: firstDate,
      lastDate: lastDate
    );
     
    if (picked != null) {
      setState(() {
        _fechaVuelo = picked;
        _result.vuelos[0].fechasalida = futil.fechaISO8601FromDateTime(picked);
        _controllerFechaVuelo.text ="${_fechaVuelo.day}/${_fechaVuelo.month}/${_fechaVuelo.year}";
      });
    }
  }


  Widget  _buttonContinuar(){
    return Container(
      width: width-20,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      color: Colors.white,
      child:FlatButton(
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.orange,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => InformacionAdicional(reserva: _reserva, result: _result,)));
        },
        child: Text(
          Translations.of(context).text('continuar'),
          style: TextStyle(fontSize: 20.0, fontFamily: "Montserrat"),
        ),
      )
    );
  }

  Widget _floatButton(){
    return new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(_funcionList.length, (int index) {
          Widget child = Align(
            alignment: Alignment.centerRight,
            child: new Container(
              height: 80.0,
              width: 300.0,
              alignment: FractionalOffset.topCenter,
              child: new ScaleTransition(
                scale: new CurvedAnimation(
                  parent: _controller,
                  curve: new Interval(
                    0.0,
                    1.0 - index / _funcionList.length / 2.0,
                    curve: Curves.easeOut
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Text(_opcionesFloat[(index+1).toString()], style: TextStyle(fontSize: 18, color:  Color(0xFFE87200)),)
                  ),
                ),
          ),
            ),
          );
          return child;
        }).toList()..add(
          Align(
            alignment: Alignment.centerRight,
            child: new FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Icon(FontAwesomeIcons.exclamationCircle , color: Colors.red,size: 28, );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            )
          ),
        ),
      );
  }
}