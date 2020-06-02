import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';

import 'package:precheckin/widgets/qr_widget.dart';
import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/providers/pms_provider.dart';
import 'package:precheckin/utils/tools_util.dart' as tools;
import 'package:precheckin/preferences/user_preferences.dart';

class VerQR extends StatefulWidget {
  static GlobalKey screen = new GlobalKey();

  @override
  _VerQRState createState() => _VerQRState();
}

class _VerQRState extends State<VerQR> {
  String _qr;
  Size _size;
  UserPreferences _pref;
  PMSProvider _provider;
  bool _bloquear = false;
  PMSBloc _pmsBloc;

  
  @override
  void initState() {
    super.initState();
    _provider = new PMSProvider(); //Provide PMS Services
    _pref     = new UserPreferences();
    _pmsBloc  = new PMSBloc();
  }


  @override
  Widget build(BuildContext context) {
    _qr = ModalRoute.of(context).settings.arguments;
    _size = MediaQuery.of(context).size;


    return Scaffold(
      body: Stack(
        children: <Widget>[
          tools.imagenFondo(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _logo(),
                  _codigosQR(context)
                ],
              ),
            ),
          ),
          tools.bloqueaPantalla(_bloquear),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.home, color: Colors.white, size: 35.0,),
        onPressed: () => (_bloquear == false) ? Navigator.pushNamed(context, 'idioma') : false,
        backgroundColor: (_bloquear == false) ? Color.fromRGBO(191, 52, 26, 1) : Color.fromRGBO(255, 255, 255, 0.5),
        elevation: 15.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

 

  Widget _logo() {
    return Container(
      width: double.infinity,
      child: SvgPicture.asset(
        'assets/images/sunset_logo.svg',
        semanticsLabel: 'Acme Logo',
        color: Colors.white,
      ),
    );
  }

  Widget _codigosQR(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height * 0.1),
      child: Column(
        children: <Widget>[
          InkWell(
            child: QRCode(
              code: _qr,
              showText: true,
            ),
            onTap: ()=>_showReserva(context),
          ),
          _btnNuevoCodigo(context)
        ],
      ));
  }

  Widget _btnNuevoCodigo(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 14.0),
      child: RaisedButton(
          child: Text(Translations.of(context).text('nuevo_code'),textAlign: TextAlign.center,style: greyText.copyWith(color: Colors.black),),
          shape: StadiumBorder(),
          color: Color.fromRGBO(255, 255, 255, 0.5),
          elevation: 12.0,
          onPressed: () => Navigator.pushNamed(context, 'nuevoCodigo')),
    );
  }


  //Ejecuta la petición al PMS para obtener la información
  //de la reservacion
  Future _showReserva(BuildContext contex) async {
    _bloquearPantalla(true);
    bool status = await _pmsBloc.setReserva(_qr);
    _bloquearPantalla(false);

    if(!status)
      tools.showAlert(context, "No se encontro información");
    else {
      _pref.tieneLigadas = _pmsBloc.tieneLigadas;

      if(_pref.tieneLigadas)
        Navigator.pushNamed(context, 'litaReserva', arguments: _pmsBloc.reserva);
      else{
        _pmsBloc.result = null;
        Navigator.pushNamed(context, 'infoTitular');
      }
    }
  }





  //Cambia el status de la bandera para 
  //determinar si se bloquea la pantalla.
  void _bloquearPantalla(bool status){
    _bloquear = status;
      setState(() {});
  }
}