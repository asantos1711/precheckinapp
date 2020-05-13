import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:signature/signature.dart';

class SignatureWidget extends StatefulWidget {
  String img;
  String title;
  SignatureController controller;

  SignatureWidget({
    this.img, 
    @required this.title,
    @required this.controller,
  });

  @override
  _SignatureWidgetState createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  double _width;
  bool _capturar;
  SignatureController _controller;


  @override
  void initState() {
    super.initState();
    _capturar   = (widget.img.isEmpty) ? false : true;
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    Widget firma = (_capturar == true) ? _image() : _firma();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.title, style: TextStyle(fontSize: 20)),
        SizedBox(height: 10.0,),
        firma
      ],
    );
  }

  Widget _image() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(border: Border.all(width: 2.0, color: Colors.grey)),
            width: _width - 20.0,
            height: 100.0,
            child: Image.memory(base64.decode(widget.img)),
          ),
          SizedBox(height: 10.0,),
          FlatButton(
            child: Text(Translations.of(context).text('change')),
            color: Colors.white,
            onPressed: () => setState(() =>  _capturar = !_capturar ),
          ),
        ],
      ),
    );
  }

  Widget _firma() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(border: Border.all(width: 2.0, color: Colors.grey)),
            child: Signature(
                controller: _controller,
                height: 100,
                width: _width - 20,
                backgroundColor: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
                FlatButton(
                  child: Text(Translations.of(context).text('limpiar')),
                  color: Colors.white,
                  onPressed: () => setState(() => _controller.clear()),
                ),
                /*FlatButton(
                  child: Text(Translations.of(context).text('cancel')),
                  color: Colors.white,
                  onPressed:(){
                     _capturar = !_capturar;
                     setState(() => _controller.clear());
                  },
                ),*/
            ],
          ),
        ],
      )
    );
  }
}
