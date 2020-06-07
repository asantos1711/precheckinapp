import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/politicas_model.dart';
import 'package:precheckin/pages/ViewWebView.dart';
import 'package:precheckin/styles/styles.dart';
class CheckTextBold extends StatelessWidget {
 
  final bool value;
  final double width;
  final Function onChange;
  final String text;
  final String textBold;
  final String viewWebVal;
  final List<Politicas> politicas;

  CheckTextBold({
    @required this.value,
    @required this.onChange,
    @required this.width,
    @required this.text,
    @required this.textBold,
    @required this.viewWebVal,
    @required this.politicas,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 40,
            child:new Checkbox(
              activeColor: Color.fromRGBO(0, 165, 227, 1),
              value: value,
              onChanged: onChange
            ),
          ),
          Container(
            width: width-40,
            child: RichText(text: TextSpan(
              text: text,
              style: greyText,
              children: <TextSpan>[
                TextSpan(
                  text: textBold,
                  style: greyText.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: 
                        (context, animation1, animation2) => 
                        ViewWebView(
                          valor : viewWebVal,
                          politicas: politicas,
                          title: textBold,
                        ),
                      )
                    );
                  }
                )
              ]
            ),),
          )
        ],
      )
    );
  }
}