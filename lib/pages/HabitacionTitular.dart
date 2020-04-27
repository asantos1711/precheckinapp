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

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _floatButton(),
      body: ListView(
        children: <Widget>[
          _numeroResrvacion()
        ],
      ),
    );
  }

  Widget _numeroResrvacion(){
    return Container(
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: width-40,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Lavel Reservación'
              ),
            ),
          )
        ]
      )
    );
  }

  /*
  Widget _numeroResrvacion(){
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        ]
      )
    );
  }
   */

  Widget _floatButton(){
    return FloatingActionButton(
      child: Icon(
        FontAwesomeIcons.plus
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