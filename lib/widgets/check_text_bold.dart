import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:precheckin/styles/styles.dart';
class CheckTextBold extends StatelessWidget {
  final String text; 
  final String textBold; 
  final Function onTap;
  final Function onChange;
  final bool value;
  final double width;

  CheckTextBold({
    @required this.text,
    @required this.textBold,
    @required this.onTap,
    @required this.value,
    @required this.onChange,
    @required this.width
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
                  ..onTap = onTap
                )
              ]
            ),),
          )
        ],
      )
    );
  }
}