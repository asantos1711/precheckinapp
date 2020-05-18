import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/pages/HabitacionTitular.dart';
import 'package:precheckin/preferences/user_preferences.dart';
import 'package:precheckin/providers/pms_provider.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/utils/tools_util.dart' as tools;
import 'package:precheckin/utils/tools_util.dart';

class CodigoAcceso extends StatefulWidget {

  @override
  _CodigoAccesoState createState() => _CodigoAccesoState();

}

class _CodigoAccesoState extends State<CodigoAcceso> {
  TextEditingController _codigoController;
  UserPreferences _pref;
  PMSProvider _provider;
  bool _bloquear = false;

  @override
  void initState() {
    super.initState();
    _codigoController = new TextEditingController();
    _provider         = new PMSProvider(); //Provide PMS Services
    _pref             = new UserPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          imagenFondo(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  logo(),
                  _textoIngresa(),
                  _textField(),
                  _ingresar(),
                ],
              ),
            )
          ),
          tools.bloqueaPantalla(_bloquear),
        ],
      ),
    );
  }
  
  Widget _textoIngresa(){
    return Container(
      margin: EdgeInsets.only(top: 100.0),
      alignment: Alignment.center,
      child: Text(
        Translations.of(context).text('ingrese_codigo'), 
        style: TextStyle(
          color: Colors.white, 
          fontSize: 17, 
          fontWeight: FontWeight.w800
        )
      )
    );
  }

  Widget _textField(){
    return  Container(
      margin: EdgeInsets.symmetric(vertical:40.0, horizontal:40.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _codigoController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      )
    );
  }

  Widget _ingresar(){
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: InkWell(
        child: Text(
          Translations.of(context).text('ingresar'), 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 21, 
            fontWeight: FontWeight.w800
          )
        ),
        onTap: () => _showReserva(context),
      )
    ); 
  }

  Future _showReserva(BuildContext contex) async {
    _bloquearPantalla(true);

    Reserva infoReserva = await _provider.dameReservacionByQR( _codigoController.text);
    
    _bloquearPantalla(false);

    if(infoReserva == null) 
      tools.showAlert(context, "No se encontro información");
    else {
      infoReserva.codigo = _codigoController.text;

      if(infoReserva.ligadas.isEmpty) {
        _pref.tieneLigadas = false;
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HabitacionTitular(reserva: infoReserva, result: infoReserva.result,)));
      } else {
        _pref.tieneLigadas = true;
       Navigator.pushNamed(context, 'litaReserva', arguments: infoReserva);
      }
    }
  }

  

  void _bloquearPantalla(bool status){
    _bloquear = status;
      setState(() {});
  }
}