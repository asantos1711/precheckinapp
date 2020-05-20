import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  final String code;
  final bool showText;
  final Widget separation = SizedBox(height: 10.0,);
  Size _size;

  QRCode({
    @required this.code,
    this.showText = false
  });


  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Column(
        children: _body()
    );
  }

  List<Widget> _body(){
    List<Widget> widgets = [];

    widgets.add( _setQR() );

    if(showText){
      
      widgets..add( separation )
             ..add( _setText() );

    }

    return widgets;
  }

  Widget _setQR(){
    return Container(
      child: QrImage(
        data: code,
        version: QrVersions.auto,
        backgroundColor: Colors.white,
        size: _size.width * 0.4,
        gapless: true,
      ),
    );
  }

  Widget _setText(){
    return Container(
      padding: EdgeInsets.symmetric(vertical:10.0, horizontal:10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Text(code, style: TextStyle(fontSize: 20.0),),
    );
  }
}