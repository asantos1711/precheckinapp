import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheckin/tools/translation.dart';


//Widget que se muestra para bloquear la pantalla
//durante la ejecución de un proceso.
Widget bloqueaPantalla(bool status) {
  Widget widget = Container();

  if(status)
    widget = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.5)
      ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 5.0,
        ),
      ),
    );

  return widget;

}



//Muestra las alertas para informar a el usuarios
//de algun evento.
void showAlert(BuildContext context, String message) {

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(Translations.of(context).text("alert")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message,textAlign: TextAlign.justify,),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: ()=> Navigator.of(context).pop(), 
              child: Text("Ok")
            ),
          ],
        );
      }

    );

}


//Widget para establecer el fondo de la patalla.
Widget imagenFondo() {
  return Container(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        "assets/images/background.png",
        fit: BoxFit.cover,
      ));
}

//Muestra el logo de la compañia.
Widget logo() {
    return Container(
        margin: EdgeInsets.only(top: 100.0),
        width: double.infinity,
        child: SvgPicture.asset(
          'assets/images/sunset_logo.svg',
          semanticsLabel: 'Acme Logo',
          color: Colors.white,
        ),
    );
  }

///Muestra una alerta para confirmar una acción,
///
///Este Future requiere de el contexto[context] en que se
///esta operando y el String [contenido] que se quiere mostrar
///en la alerta. Regresa un [bool] como respuesta,
Future<bool> confimarAccion(BuildContext context, String contenido) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(Translations.of(context).text("alert")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(contenido, textAlign: TextAlign.justify),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true), 
              child: Text(Translations.of(context).text('confirm'))
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false), 
              child: Text(Translations.of(context).text('cancel'), style: TextStyle(color: Theme.of(context).primaryColor),)
            ),
          ],
        );
      }
    );
  }