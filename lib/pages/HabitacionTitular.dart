import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/styles/styles.dart';

import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/widgets/paises_widget.dart';
import 'package:precheckin/widgets/estados_widget.dart';

class HabitacionTitular extends StatefulWidget {
  @override
  _HabitacionTitularState createState() => _HabitacionTitularState();
}

class _HabitacionTitularState extends State<HabitacionTitular> with TickerProviderStateMixin{

  Reserva _reserva;  
  String _pais;
  String _estado;
  double height;
  double width;
  double space;
  final _backgroundBloqueado = Color(0XFFF5F5F5);
  final _boxDecorationDefault = BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1)));
  TextEditingController _controllerNombre = new TextEditingController();
  TextEditingController _controllerCP = new TextEditingController();
  TextEditingController _controllerCiudad = new TextEditingController();



  AnimationController _controller;
  static const List<String> _funcionList = const [ "1","2" ];
  Map<String,String> _opcionesFloat = new  Map<String,String>();


  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    _reserva = ModalRoute.of(context).settings.arguments; //Obtiene la informacion que biene de los argumentos.

    _inicializarDatos();//Inicializa las variables.

    return GestureDetector(
      onTap: () {

        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus)
          currentFocus.unfocus();
      },
      child:Scaffold(
        appBar: _appBar(),
        floatingActionButton: _floatButton(),
        body: _body(),
      )
    );
  }


  void _inicializarDatos() {
    _controllerNombre.text = _reserva.result.nombreTitular;
    _controllerCP.text = _reserva.result.codigoPostal;
    _controllerCiudad.text = _reserva.result.ciudad;
    _pais = (_pais == null) ? _reserva.result.pais : _pais; //Validacion para que cambie el valor del pais
    _estado = (_estado == null) ? _reserva.result.estado : _estado; //Validacion para que cambie el valor del estado

    _opcionesFloat["1"] = Translations.of(context).text('opcion_duda').toString();
    _opcionesFloat["2"] = Translations.of(context).text('opcion_error').toString();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

  Widget _appBar(){
    //TODO: Cambiar el texto por la etiqueta de ingles español
    return AppBar(
      backgroundColor: Color(0xFFE87200),
      leading: Container(),
      title:Text('Información de reservación', style: appbarTitle)
    );
  }

  Widget _body() {
    return ListView(
      children: <Widget>[
        _seccionReserva(),
        _seccionTitular(),
        _seccionContacto(),
        _seccionVuelo(),
        _buttonContinuar(),
      ],
    );
  }

  Widget _seccionReserva(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal:10.0, vertical:10.0),
      decoration: BoxDecoration(
        color: _backgroundBloqueado,
      ),
      child: Column(
        children: <Widget>[
          _numeroReservacion(),
          _llegadaSalida(),
          _huespedes(),
          _tipoHabitacion(),
          _planViaje(),
          _requeEspeciales(),
        ]
      ),
    );
  }

  Widget _seccionTitular(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical:10.0),
      child: Column(
        children: <Widget>[
          _infoTitular(),
        ]
      ),
    );
  }

  Widget _seccionContacto(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal:10.0, vertical:10.0),
      decoration: BoxDecoration(
        color: _backgroundBloqueado
      ),
      child: Column(
        children: <Widget>[
          _infoContacto(),
        ]
      ),
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

  Widget _numeroReservacion(){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 7),
      width: (width-40),
      decoration: _boxDecorationDefault,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                'No. De Reservación',
                style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                )
            ),
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                    _reserva.result.idReserva.toString(),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 5,)
        ],
      )
    );
  }

  Widget _llegadaSalida(){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 7),
      width: (width-40),
      decoration: _boxDecorationDefault,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      'Llegada',
                      style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Text(
                      'Salida',
                      style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                      )
                  ),
                ),
              ],
            )
          ),
          SizedBox(height: 5,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      _reserva.result.fechaCheckin,
                      style: TextStyle(fontSize: 18),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Text(
                      _reserva.result.fechaCheckout,
                      style: TextStyle(fontSize: 18),
                      )
                  ),
                ),
              ],
            )
          ),
          SizedBox(height: 5,)
        ],
      )
    );
  }

  Widget _huespedes(){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 7),
      width: (width-40),
      decoration: _boxDecorationDefault,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    'Huespedes',
                    style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                  )
                )
              ],
            )
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      '${_reserva.result.numeroAdultos} Adultos',
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                      '${_reserva.result.numeroAdolecentes} Adolecentes',
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Text(
                      '${_reserva.result.numeroNinios} Niños',
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                      )
                  ),
                ),
              ],
            )
          ),
          SizedBox(height: 5,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      '+18',
                      style: TextStyle(fontSize: 18),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                      '+12 a -18',
                      style: TextStyle(fontSize: 18),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Text(
                      '-12',
                      style: TextStyle(fontSize: 18),
                      )
                  ),
                ),
              ],
            )
          ),
          SizedBox(height: 5,)
        ],
      )
    );
  }

  Widget _tipoHabitacion(){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 7),
      width: (width-40),
      decoration: _boxDecorationDefault,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                'Tipo de habitación',
                style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                )
            ),
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(_reserva.tipoHabitacion.descripcion ?? '',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 5,)
        ],
      )
    );
  }
  
  Widget _planViaje(){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 10),
      width: (width-40),
      //decoration: _decoration(),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                'Plan de viaje',
                style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                )
            ),
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left:10),
              child: Text(_reserva.result.planViaje,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 5,)
        ],
      )
    );
  }
  
  Widget _requeEspeciales(){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
      width: (width-40),
      //decoration: _decoration(),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                'Requerimientos especiales',
                style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                )
            ),
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left:10),
              child: Text(_reserva.result.requerimientos,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left:10),
              child: Text(_reserva.result.requerimientos,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              //padding: EdgeInsets.only(left:10),
              child: Text('*Sujeto a disponibilidad',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _infoTitular(){
    Color _blue = Color.fromARGB(255,63, 90, 166);
    return Container(
      margin: EdgeInsets.only( bottom: 5),
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
                'Información del Titular',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: _blue
                ),
              ),
              decoration: _boxDecorationDefault,
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(right: 15, left:15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10),
                  width: (width-50)/2,
                  child: TextFormField(
                    controller: _controllerNombre,
                    decoration: InputDecoration(
                      labelText: "Nombre"
                    ),

                    onChanged: (nombre){

                      _reserva.result.nombreTitular = nombre;

                    },

                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: (width-50)/2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Apellido"
                    ),
                  )
                )
              ],
            )
          ),
          Container(
            padding: EdgeInsets.only(right: 15, left:15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _dropdownPaises(),
                _dropdownEstado(),
                ],
            )
          ),
          Container(
            padding: EdgeInsets.only(right: 15, left:15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10),
                  width: (width-50)/2,
                  child: TextFormField(
                    controller: _controllerCiudad,
                    decoration: InputDecoration(
                      labelText: "Ciudad"
                    ),
                    onChanged: (ciudad) {

                      _reserva.result.ciudad = ciudad;

                    },
                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: (width-50)/2,
                  child: TextFormField(
                    controller: _controllerCP,
                    decoration: InputDecoration(
                      labelText: "Código Postal"
                    ),
                    onChanged: (cp){
                      _reserva.result.codigoPostal = cp;
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
      padding: EdgeInsets.only(top: 19, right: 10),
      child: PaisesWidget(
        hotel:"0",
        valorInicial: _pais,
        change: (pais){
          setState(() {
            _pais = pais;
            _reserva.result.pais = pais;
          });
        },
      ),
    );
  }

  Widget _dropdownEstado(){
    
    return Container(
      width: (width-50)/2,
      padding: EdgeInsets.only(top: 19, right: 10),
      child: EstadosWidget(
        hotel:"0",
        pais: _pais,
        valorInicial: _estado,
        change: (estado){
          setState(() {
            _estado = estado;
            _reserva.result.estado = estado;
          });
        },
      ),
    );
  }
  
  Widget _infoContacto(){
    return Container(
      margin: EdgeInsets.only( bottom: 5),
      padding: EdgeInsets.all(10),
      width: width,
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
                'Información del Contacto',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16
                ),
              ),
              decoration: _boxDecorationDefault,
            ),
          ),
          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 7),
            width: (width-40),
            decoration: _boxDecorationDefault,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      'Correo Electronico',
                      style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                      )
                  ),
                ),
                SizedBox(height: 5,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(_reserva.result.email,
                      style: TextStyle(fontSize: 18),
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
            decoration:_boxDecorationDefault,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      'Teléfono',
                      style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),
                      )
                  ),
                ),
                SizedBox(height: 5,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(_reserva.result.telefono,
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
  
  Widget _infoVuelo(){
    Color _blue = Color.fromARGB(255,63, 90, 166);
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
                'Agregar Información del vuelo',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: _blue
                ),
              ),
              decoration: _boxDecorationDefault,
            ),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: width-30,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "No. De Vuelo"
              ),
              onChanged: (numeroVuelo) {
                //TODO: Falta el número de vuelo en el servicio.
              },
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: (width-30)/2,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Fecha de Salida"
              ),
              onChanged: (fechaVuelo){
                //TODO: Falta la fecha de vuelo en el servicio.
              },
            )
          )
        ],
      )
    );
  }

  Widget  _buttonContinuar(){
    return Container(
      width: width-20,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      color: Colors.white,
      child:FlatButton(
        color: Color(0xFFE87200),
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.orange,
        onPressed: () {



          Navigator.pushNamed(context, 'infoAdicional', arguments: _reserva);


         
        },
        child: Text(
          "Continuar",
          style: TextStyle(fontSize: 20.0),
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
                    child: Text(_opcionesFloat[(index+1).toString()], style: TextStyle(fontSize: 18, color: Colors.deepOrange),)
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