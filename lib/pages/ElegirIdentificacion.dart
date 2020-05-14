import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mrzflutterplugin/mrzflutterplugin.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/DisplayPictureScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/ScanerModel.dart';
import '../models/commons/acompaniantes_model.dart';
class ElegirIdentificacion extends StatefulWidget {
  Acompaniantes acompaniantes;
  ElegirIdentificacion({
    @required this.acompaniantes
  });
  @override
  _ElegirIdentificacionState createState() => _ElegirIdentificacionState();
}
class TipoDoc {
  String name;
  int index;
  Icon icon;
  String short;
  TipoDoc({this.name, this.index, this.icon,this.short});
}
class _ElegirIdentificacionState extends State<ElegirIdentificacion> {
  String name;
  int index;
  String nameItem ;
  int idItem ;
  TipoDoc _isSelect = null;
  ScanerModel _scanerModel = new ScanerModel();
  String fullImage;
  Acompaniantes acompaniantes;
  // Obtén una lista de las cámaras disponibles en el dispositivo.
  CameraController controller;
  Future<void> initializeControllerFuture;
  


  @override
  void initState() {
    acompaniantes = this.widget.acompaniantes;
    super.initState();
    
  }

  String _result = 'No result yet';
   List<TipoDoc> docList = [
    TipoDoc(
      index: 0,
      name: "Pasaporte",
      short: "P",
      icon: Icon(FontAwesomeIcons.circle)
    ),
    TipoDoc(
      index: 1,
      short:"ID",
      name: "Documento de Identificación",
      icon: Icon(FontAwesomeIcons.circle)
    ),
  ];

  _camera(CameraDescription camera){
    controller = CameraController(
      camera,
      ResolutionPreset.ultraHigh,
    );

    // A continuación, debes inicializar el controlador. Este devuelve un Future
    initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    // Asegúrate de eliminar el controlador cuando se elimine el Widget.
    controller?.dispose();
    super.dispose();
  }

  _onChange(String nombre, int index){
      nameItem = nombre;
      idItem = index;
      docList[index].icon = Icon(FontAwesomeIcons.checkCircle);
      //setState(() {
      docList.forEach((d){
        if(d.index!=index){
          d.icon = Icon(FontAwesomeIcons.circle);
        }
      });
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appbar(),
      body: Column(
      children: <Widget>[
          _headerText(),
          _lista(),
          _aviso(),
          _buttonContinuar()
        ],
      )
    );
  }

  Widget _aviso(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child:Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            child: Icon(Icons.lock)
          ),
          Expanded(
            child: Text(Translations.of(context).text('no_compartir'))
          )
        ],
      )
    );
  }

  Widget _lista(){
    return Expanded(
          child: ListView.builder(
          itemCount: docList.length,
          itemBuilder: (context, item) {
            TipoDoc doc = docList[item];
            return  Container(
              width: MediaQuery.of(context).size.width-40,
              decoration: _decoration(),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(doc.name),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap:(){
                        //setState(() {
                          nameItem = doc.name;
                          idItem = item;
                          _isSelect = doc;
                          //docList[idItem].icon = Icon(FontAwesomeIcons.checkCircle);
                          setState(() {
                           docList.forEach((d){
                            if(d.index!=item){
                              d.icon = Icon(FontAwesomeIcons.circle);
                            }else{
                              d.icon = Icon(FontAwesomeIcons.checkCircle, color: Colors.green,);
                            }
                          }); 
                        });
                      },
                      splashColor: Colors.grey,
                      child: doc.icon
                    ),
                  ),
                ],
              )
            );
          },
        ),
    );
  }

  Widget _headerText(){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        Translations.of(context).text('selec_tipo_doc'),
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600,)
      ),
    );
  }

  Widget _appbar() {
    return new AppBar(
      leading: Container(),
      title: Text(Translations.of(context).text('doc_identificacion'),style:TextStyle(fontFamily: "Montserrat", fontSize: 17.0,)),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              size: 26.0,
            ),
          )
        ),
      ],
    );
  }

  BoxDecoration _decoration (){
    return BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey, width: 1))
    );
  }


  Widget  _buttonContinuar(){
    return Container(
      width: MediaQuery.of(context).size.width-20,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      color: Colors.white,
      child:FlatButton(
        color:  Color(0xFFBF341A),
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        onPressed: () async {
          if(_isSelect == null){
            Fluttertoast.showToast(
              msg: "Selecciona un tipo de documento",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 20.0
          );
          }else{
            if(_isSelect.short == 'P'){
              _flujopasaporte();
            }else if(_isSelect.short =='ID'){
              _flujoId();
            }
          }
        },
        child: Text(
          Translations.of(context).text('continuar'),
          style: TextStyle(fontSize: 20.0),
        ),
      )
    );
  }

  _flujoId()async{
    Alert(
      closeFunction:(){
        print('Se cerró la alerta');
      } ,
      context: context,
      image: Image.asset('assets/images/id_front.png'),
      title: "",
      content: Container(child: Text('Acontinuación deberá capturar una foto de la parte frontal de su documento de identificación.\nAsegurese que la imagen sea clara y visible.'),),
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: () async{
            Navigator.pop(context);
            final cameras = await availableCameras();
            final firstCamera = cameras.first; 
            _camera(firstCamera);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return _vistaCamara();
                },
              ),
            );
          } ,
          child: Text(
            Translations.of(context).text('continuar'),
            style: TextStyle(color: Colors.blueAccent, fontSize: 20),
          ),
        )
      ]
    ).show();
  }

  Widget _vistaCamara(){
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(children: <Widget>[
         Container(
            width:width,
            height: width*1.25,
            child: _iniciarCamara(),
            /* decoration: BoxDecoration(
              border: Border.all(width: 5, color: Colors.grey.withAlpha(500) ),
            ), */
          )

      ],),
      floatingActionButton: _takePhoto(),
    );
  }

  _flujopasaporte(){
    Alert(
      closeFunction:(){
        print('Se cerró la alerta');
      } ,
      context: context,
      image: Image.network('https://image.shutterstock.com/image-vector/vector-illustration-passport-biometric-data-260nw-761890669.jpg'),
      title: "",
      content: Container(child: Text('A continuación se escaneará el Pasaporte.\nAsegurese de exista una imagen clara y visible.'),),
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
            startScanning();
          } ,
          child: Text(
            Translations.of(context).text('continuar'),
            style: TextStyle(color: Colors.blueAccent, fontSize: 20),
          ),
        )
      ]
    ).show();
    
  }

  _takePhoto(){
    return FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await initializeControllerFuture;
            final path = join( 
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            await controller.takePicture(path);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      );
  }

  _iniciarCamara(){
    return FutureBuilder<void>(
      future: initializeControllerFuture ,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(controller);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Future<void> startScanning() async {
    String scannerResult;
    ScanerModel res;
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
        
      scannerResult = jsonResult.toString();
      
      print(scannerResult);
    } on PlatformException catch (ex) {
      String message = ex.message;
      scannerResult = 'Scanning failed: $message';
    }
    
    if (!mounted) return;

    setState(() {
      _scanerModel = res;
      _result = scannerResult;
      acompaniantes.documenttype = _scanerModel.documentTypeReadable;
      acompaniantes.imagefront = _scanerModel?.portrait ??'';
      acompaniantes.nombre = _scanerModel.givenNamesReadable;

      log('imagefront: ${acompaniantes.imagefront}');
    });
    _scanerModel.documentTypeReadable!=null ?_alertScannerR() : (){}; 
  }

  _alertScannerR(){
    return Alert(
        closeFunction:(){
          print('Se cerró la alerta');
          Navigator.pop(context);
          Navigator.pop(context);
        } ,
        context: context,
        title: "Escaneo de Pasaporte",
        content: Container(child: Text('El escaneo del pasaporte se ha realizado con éxito.'),),
        buttons: [
          DialogButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            } ,
            child: Text(
              Translations.of(context).text('finalizar'),
              style: TextStyle(color: Colors.blueAccent, fontSize: 20),
            ),
          )
        ]
      ).show();
  }
}


