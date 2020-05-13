import 'package:flutter/material.dart';
import 'package:precheckin/pages/ElegirIdentificacion.dart';
import 'package:precheckin/tools/translation.dart';

class DocIdentificacion extends StatefulWidget {
  @override
  _DocIdentificacionState createState() => _DocIdentificacionState();
}

class _DocIdentificacionState extends State<DocIdentificacion> {
  double _width;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      width: _width-20,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            // width: ((width-20)/3)*2,
            child: Text(Translations.of(context).text('doc_identificacion'),style: TextStyle(color: Colors.blueAccent,fontSize: 18),)
          ),
          Container(
            alignment: Alignment.centerRight,
            //width: (width-20)/3,
            child: InkWell(
              splashColor: Colors.grey,
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => ElegirIdentificacion(),
                    )
                  );
                },
                child:Icon(Icons.camera_alt, color: Colors.blue, size: 30,)
              )
          )
        ],
      )
    );
  }
}