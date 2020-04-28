import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/pages/InformacionAdicional.dart';
import 'package:precheckin/tools/translation.dart';

class HabitacionTitular extends StatefulWidget {
  @override
  _HabitacionTitularState createState() => _HabitacionTitularState();
}

class _HabitacionTitularState extends State<HabitacionTitular> with TickerProviderStateMixin{

  double height;
  double width;
  double space;
  TextEditingController _controllerNoReservacion = new TextEditingController(text: '465');
  TextEditingController _controllerLlegada = new TextEditingController(text: '12/11/2020');
  TextEditingController _controllerSalida = new TextEditingController(text: '20/11/2020');
  TextEditingController _controllerAdultos = new TextEditingController(text: '465');
  TextEditingController _controllerAdolocentes = new TextEditingController(text: '465');
  TextEditingController _controllerNinos = new TextEditingController(text: '465');
  //TextEditingController _controllerNoReservacion = new TextEditingController(text: '465');
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

    _opcionesFloat["1"] = Translations.of(context).text('opcion_duda').toString();
    _opcionesFloat["2"] = Translations.of(context).text('opcion_error').toString();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }

      },
      child:Scaffold(
        appBar: _appBar(),
        floatingActionButton: _floatButton(),
        body: ListView(
          children: <Widget>[
            _numeroReservacion(),
            _llegadaSalida(),
            _huespedes(),
            _tipoHabitacion(),
            _planViaje(),
            _requeEspeciales(),
            _infoTitular(),
            _infoContacto(),
            _infoVuelo(),
            _buttonContinuar(),
            Container( height: 30, color: Colors.white,)
          ],
        ),
      )
    );
  }

  Widget _buttonContinuar(){
    return Container(
      width: width-20,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      color: Colors.white,
      child:FlatButton(
        color: Colors.deepOrange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => InformacionAdicional(),
            )
          );
        },
        child: Text(
          "Continuar",
          style: TextStyle(fontSize: 20.0),
        ),
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
              decoration: _decoration(),
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
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: (width-30)/2,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Fecha de Salida"
              ),
            )
          )
        ],
      )
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
              decoration: _decoration(),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 7),
            width: (width-40),
            decoration: _decoration(),
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
                    child: Text('correo@correo.com',
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
            decoration: _decoration(),
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
                    child: Text('998155151',
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
              decoration: _decoration(),
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
                    decoration: InputDecoration(
                      labelText: "Nombre"
                    ),
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
                Container(
                  padding: EdgeInsets.only(right: 10),
                  width: (width-50)/2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "País de residencia"
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: (width-50)/2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Estado"
                    ),
                  )
                ),
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
                    decoration: InputDecoration(
                      labelText: "Ciudad"
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: (width-50)/2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Código Postal"
                    ),
                  )
                )
              ],
            )
          ),
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
              child: Text('Vista al mar*',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left:10),
              child: Text('Primer piso*',
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
              child: Text('All-inclusive',
                style: TextStyle(fontSize: 18),
              ),
            ),
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
      decoration: _decoration(),
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
              child: Text('Two Bedroom',
                style: TextStyle(fontSize: 18),
              ),
            ),
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
      decoration: _decoration(),
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
                      'n Adultos',
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                      'n Adolecentes',
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Text(
                      'n Niños',
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

  Widget _llegadaSalida(){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 7),
      width: (width-40),
      decoration: _decoration(),
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
                      '10/12/2020',
                      style: TextStyle(fontSize: 18),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Text(
                      '15/12/2020',
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

  Widget _numeroReservacion(){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 7),
      width: (width-40),
      decoration: _decoration(),
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
              child: Text('1415156',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 5,)
        ],
      )
    );
  }

  BoxDecoration _decoration (){
    return BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey, width: 1))
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

  Widget _appBar(){
    return AppBar(
      backgroundColor: Colors.deepOrange,
      leading: Container(),
      title:Text('Información de reservación') ,
    );
  }
}