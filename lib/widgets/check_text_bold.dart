import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
              activeColor: Colors.blue,
              value: value,
              onChanged: onChange
            ),
          ),
          Container(
            width: width-40,
            child: RichText(text: TextSpan(
              text: text,
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: textBold,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
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
/*
class _CheckTextBoldState extends State<CheckTextBold> {
  double _width;
  String _text; 
  String _textBold; 
  Function _onTap;
  bool _value;

  @override
  void initState() {
    super.initState();
    //_checkbox = this.widget.checkbox;
    _onTap = this.widget.onTap;
    _text = this.widget.text;
    _textBold = this.widget.textBold??'';
    _value = this.widget.value;
  }

  _changeValue(){
    setState(() {
      this.widget.value = !this.widget.value;
      print('${this.widget.value}');
    });
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
            child:new Checkbox(
              activeColor: Colors.blue,
              value: this.widget.value,
              onChanged: (bo){
                _changeValue();
              }
            ),
          ),
          Container(
            width: _width-40,
            child: RichText(text: TextSpan(
              text: _text,
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
}*/