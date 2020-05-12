import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:precheckin/preferences/user_preferences.dart';
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/widgets/idiomas_widget.dart';
import 'package:precheckin/utils/tools_util.dart';

class ChooseLanguage extends StatelessWidget {

  QRPersistence _persitence = new QRPersistence();
  UserPreferences _usrPref = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _imagenFondo(),
          _contenido(context),
        ],
      )
    );
  }

  Widget _imagenFondo() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        "assets/images/background.png",
        fit: BoxFit.cover,
      )
    );
  }
  
  Widget _contenido(BuildContext context){
    return Container(
      margin: EdgeInsetsDirectional.only(top: 150.0),
      child: Column(
        children: <Widget>[
          _logo(),
          _banderas(context)
        ],
      ),
    );
  }

  Widget _logo(){
    return SvgPicture.asset(
      'assets/images/sunset_logo.svg',
      color: Colors.white,
    );
  }

  Widget _banderas(BuildContext context){
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Idimonas(),
    );
  }
}