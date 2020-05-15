import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mrzflutterplugin/mrzflutterplugin.dart';
import 'package:precheckin/models/ScanerModel.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/pages/ElegirIdentificacion.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
              style: TextStyle(color: Colors.blueAccent,fontSize: 18),
              maxLines: 2,
              ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //alignment: Alignment.centerRight,
                //width: (width-20)/3,
                child: InkWell(
                  splashColor: Colors.grey,
                    onTap: (){
                      //startScanning();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => ElegirIdentificacion(acompaniantes: acompaniantes,),
                        )
                      ); 
                    },
                    child:_condicionIcono()?
                      Icon(Icons.check_circle_outline, color:Colors.green, size: 30,):
                      Icon(Icons.camera_alt, color: Colors.blue, size: 30,)
                  )
              )
            ],
          )
        ],
      )
    );
  }

  bool _condicionIcono(){
    bool condicion =  acompaniantes.imageback!=null
    &&acompaniantes.imagefront !=null
    &&acompaniantes.imageback.length>10
    &&acompaniantes.imagefront.length>10 ;
    print('condicion'+condicion.toString());
    return condicion;
  }


  Future<void> startScanning() async {
    String scannerResult;
    ScanerModel res;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      Mrzflutterplugin.setIDActive(true);
      Mrzflutterplugin.setPassportActive(true);
      Mrzflutterplugin.setVisaActive(true);

      String jsonResultString = await Mrzflutterplugin.startScanner;

      Map<String, dynamic> jsonResult = jsonDecode(jsonResultString);
      res = ScanerModel.fromJson(jsonResult);

      print('====JSonSacaner===');
      jsonResult.forEach((key, value) {
        print('${key}-: ${value}');
      });
      print('===================');
      fullImage = jsonResult['full_image'];
        
      scannerResult = jsonResult.toString();
      
      print(scannerResult);
    } on PlatformException catch (ex) {
      String message = ex.message;
      scannerResult = 'Scanning failed: $message';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {return;};

    setState(() {
      _scanerModel = res;
      _result = scannerResult;
      acompaniantes.documenttype = _scanerModel.documentTypeReadable;
      acompaniantes.idcard = _scanerModel.optionals;
    });
    _alerta(false);
  }


  _alerta(bool error){
    Alert(
        closeFunction:(){
          print('Se cerró la alerta');
        } ,
        context: context,
        title: "Datos Escaneados",
        content: !error ? Container(child:_containerAlert()): Container(child: Text('No se escaneo ningun documento'),),
        buttons: [
          DialogButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            } ,
            child: Text(
              Translations.of(context).text('finalizar'),
              style: TextStyle(color: Colors.blueAccent, fontSize: 20),
            ),
          )
        ]).show();
  }

  _containerAlert(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Divider(height: 1,color: Colors.grey,),
          TextField(
            readOnly:true,
            controller: new TextEditingController(text: '${_scanerModel.givenNamesReadable}'),
            decoration: InputDecoration(labelText: Translations.of(context).text('nombre')),
          ),
          TextField(
            readOnly:true,
            controller: new TextEditingController(text: '${_scanerModel.surname}'),
            decoration: InputDecoration(labelText: Translations.of(context).text('apellido')),
          ),
          TextField(
            readOnly:true,
            controller: new TextEditingController(text: '${_scanerModel.sex}'),
            decoration: InputDecoration(labelText: Translations.of(context).text('sexo')),
          ),
          TextField(
            readOnly:true,
            controller: new TextEditingController(text: '${_scanerModel.documentTypeRaw}'),
            decoration: InputDecoration(labelText: Translations.of(context).text('tipo_docu')),
          ),
        ],
      ),
    );
  }
}