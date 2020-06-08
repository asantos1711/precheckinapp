import 'package:flutter/material.dart';
import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/tools/translation.dart';

class BtnEncuestaSalud extends StatelessWidget {
  PMSBloc pmsBloc;
  int posicion;
  Color textColor = Colors.white;
  Color backGround = Color(0xff3F5AA6);
  Widget icon = Container();

  BtnEncuestaSalud({
    @required this.pmsBloc,
    @required this.posicion
  });

  
  @override
  Widget build(BuildContext context) {
    if(pmsBloc.verificarEncuenta(posicion)){
      backGround = Color(0xff37a981);
      icon = Icon(Icons.check_circle_outline, color:Colors.white, size: 30);
    }

    return FlatButton(
      textColor: textColor,
      color: backGround,
      padding: EdgeInsets.all(8.0),
      splashColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(Translations.of(context).text('covid_cuestionary')),
          SizedBox(width: 5.0,),
          icon
        ],
      ),
      onPressed: (){
        pmsBloc.position = posicion;
        Navigator.pushNamed(context, "questionsCovid");
      },
    );
  }
}