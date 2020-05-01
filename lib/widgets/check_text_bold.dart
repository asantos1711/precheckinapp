import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CheckTextBold extends StatefulWidget {
  String text; 
  String textBold; 
  Checkbox checkbox;
  Function onTap;

  CheckTextBold({
    this.text,
    this.textBold,
    this.checkbox,
    this.onTap
  });
  @override
  _CheckTextBoldState createState() => _CheckTextBoldState();
}

class _CheckTextBoldState extends State<CheckTextBold> {
  double _width;
  String _text; 
  String _textBold; 
  Checkbox _checkbox;
  Function _onTap;

  @override
  void initState() {
    _checkbox = this.widget.checkbox;
    _onTap = this.widget.onTap;
    _text = this.widget.text;
    _textBold = this.widget.textBold;
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      width: _width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 40,
            child: _checkbox,
          ),
          Container(
            width: _width-40,
            child: RichText(text: TextSpan(
              text: _textBold,
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: _textBold,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                  ..onTap = _onTap
                )
              ]
            ),),
          )
        ],
      )
    );
  }
}