import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mrzflutterplugin/mrzflutterplugin.dart';
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
  Acompaniantes acompaniantes;
  String _result = 'No result yet';
  ScanerModel _scanerModel = new ScanerModel();
  String fullImage;

  @override
  void initState() {
    super.initState();
    acompaniantes = this.widget.acompaniantes;
    if (Platform.isAndroid) {
      Mrzflutterplugin.registerWithLicenceKey("4407D781D3E68EB49AFB4D61D393FAB249AD7123F675E4DC4A27B174FD37B822B9EDC20531A066B0D2994E6A18EA23EC50A3B8CB60B34B62ABDC0B3234799299");
    } else if (Platform.isIOS) {
      Mrzflutterplugin.registerWithLicenceKey("C500C89F1E88DC48B05981B3CB55CEB287CB42CEC4886223D30555F0DE9B7C036E6C0BB2563CB6B933376B3590FA5FA52B5AAC55F8FA6F90777EAC1474E360655681C3AA91770BEBC3E2C524BBFB05E8");
    }
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: InkWell(
                  splashColor: Colors.grey,
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => ElegirIdentificacion(acompaniantes: acompaniantes,),
                        )
                      ); 
                    },
                    child:_condicionIcono()?
                      Icon(Icons.check_circle_outline, color:Colors.green, size: 30,):
                      Icon(Icons.camera_alt, color: Color.fromRGBO(0, 165, 227, 1), size: 30,)
                  )
              )
            ],
          )
        ],
      )
    );
  }

  bool _condicionIcono(){
    bool condicion =  (acompaniantes.imageback!=null
      &&acompaniantes.imagefront !=null
      &&acompaniantes.imagefront !=''
      &&acompaniantes.imagefront !=''
      )
      &&acompaniantes.imageback.length>10
      &&acompaniantes.imagefront.length>10 ;
    return condicion;
  }
}