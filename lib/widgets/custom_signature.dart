import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:signature/signature.dart';

class CustomSignature extends StatefulWidget {
  SignatureController controller;
  CustomSignature({
    this.controller,
  });

  @override
  _CustomSignatureState createState() => _CustomSignatureState();
}

class _CustomSignatureState extends State<CustomSignature> {
  SignatureController _controller ;
  double width;

  @override
  void initState() {
    // TODO: implement initState
    _controller = this.widget.controller;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /* Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10),
            child: Text('Ingresa firma de titular', style: TextStyle(fontSize: 20),)
          ), */
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,color: Colors.grey
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(0.0) //         <--- border radius here
              ),
            ),
            child: Signature(
              controller: _controller, 
              height :100,
              width: width-20,
              backgroundColor: Colors.white
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                /* FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() async {
                      var data = await _controller.toPngBytes();
                      _acompaniantes.imagesign = base64.encode(data);
                      debugPrint(_acompaniantes.imagesign);
                    });
                  },
                  child: Text(Translations.of(context).text('guardar'))
                ), */
                FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                  child: Text(Translations.of(context).text('limpiar'))
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}