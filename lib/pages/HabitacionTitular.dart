import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HabitacionTitular extends StatefulWidget {
  @override
  _HabitacionTitularState createState() => _HabitacionTitularState();
}

class _HabitacionTitularState extends State<HabitacionTitular> {
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
  
  
  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floatButton(),
      body: ListView(
        children: <Widget>[
          _numeroReservacion(),
          _llegadaSalida(),
          _huespedes(),
        ],
      ),
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
    return FloatingActionButton(
      backgroundColor: Colors.white,
      child: Icon(
        FontAwesomeIcons.exclamationCircle,
        color: Colors.red,
      ),
      onPressed: null
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