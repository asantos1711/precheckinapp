import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:precheckin/preferences/user_preferences.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/utils/tools_util.dart' as tools;
import 'package:precheckin/blocs/pms_bloc.dart';

class CodigoAcceso extends StatefulWidget {

  @override
  _CodigoAccesoState createState() => _CodigoAccesoState();

}

class _CodigoAccesoState extends State<CodigoAcceso> {
  TextEditingController _codigoController;
  UserPreferences _pref;
  bool _bloquear = false;
  PMSBloc _pmsBloc;

  @override
  void initState() {
    super.initState();
    _codigoController = new TextEditingController();
    _pref             = new UserPreferences();
    _pmsBloc          = new PMSBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          tools.imagenFondo(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  tools.logo(),
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
      child: Text(Translations.of(context).text('ingrese_codigo'), style: defaultCodeCapture)
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
        style: greyText,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon:FaIcon(FontAwesomeIcons.qrcode, color: Colors.black,),
            onPressed: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              var result = await BarcodeScanner.scan();
              if(result.rawContent.isNotEmpty){
                _codigoController.text = result.rawContent;
                _showReserva(context);
              }
            },
          ),
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
            fontFamily: "Montserrat",
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
    bool status = await _pmsBloc.setReserva(_codigoController.text);
    _bloquearPantalla(false);


    if(status) {
      _pref.tieneLigadas = _pmsBloc.tieneLigadas;

      if(_pref.tieneLigadas)
        Navigator.pushNamed(context, 'litaReserva', arguments: _pmsBloc.reserva);
      else{
        _pmsBloc.result = null;
        Navigator.pushNamed(context, 'infoTitular');
      }
    } 
    else
      tools.showAlert(context, "No se encontro información");
  }

  

  void _bloquearPantalla(bool status){
    _bloquear = status;
      setState(() {});
  }
}