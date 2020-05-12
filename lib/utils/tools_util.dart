import 'package:flutter/material.dart';


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

void showAlert(BuildContext context, String message) {

  showDialog(

      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text("Alerta"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message),
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