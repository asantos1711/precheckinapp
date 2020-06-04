import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mrzflutterplugin/mrzflutterplugin.dart';
import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/models/ScanerModel.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/pages/ElegirIdentificacion.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';

class DocIdentificacion extends StatefulWidget {
  Acompaniantes acompaniantes;
  DocIdentificacion({this.acompaniantes});
  @override
  _DocIdentificacionState createState() => _DocIdentificacionState();
}

class _DocIdentificacionState extends State<DocIdentificacion> {
  double _width;
  PMSBloc _pmsBloc ;//= new PMSBloc();
  bool condicion = false;
  Acompaniantes acompaniantes;
  String _result = 'No result yet';
  ScanerModel _scanerModel = new ScanerModel();
  String fullImage;

  @override
  void initState() {
    _pmsBloc = new PMSBloc();
    acompaniantes = this.widget.acompaniantes; //.acompaniantes[index];
    condicion = _condicionIcono();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    setState(() {
      acompaniantes=acompaniantes;
        condicion = _condicionIcono();
    });
    return Container(
      color: Colors.white,
      width: _width-20,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(Translations.of(context).text('doc_identificacion'),
              style: lightBlueText.copyWith(fontSize: 15),
              maxLines: 2,
              ),
          ),
         InkWell(
          splashColor: Colors.grey,
            onTap: (){
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                    ElegirIdentificacion(
                      acompaniantes: acompaniantes,
                    ),
                )
              ); 
            },
            child:condicion?
              Icon(Icons.check_circle_outline, color:Colors.green, size: 30,):
              Icon(Icons.camera_alt, color: Color.fromRGBO(0, 165, 227, 1), size: 30,)
          )
        ],
      )
    );
  }

  bool _condicionIcono(){
    
    bool condicion =  (acompaniantes.imageback!=null
      &&acompaniantes.imagefront !=null
      &&acompaniantes.imagefront !=''
      &&acompaniantes.imageback !=''
      )
      /* &&acompaniantes.imageback.length>10
      &&acompaniantes.imagefront.length>10  */;
    return condicion;
  }
}