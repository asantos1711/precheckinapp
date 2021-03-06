import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:camera_camera/camera_camera.dart';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mrzflutterplugin/mrzflutterplugin.dart';
import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/providers/configuracion_provider.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../models/ScanerModel.dart';
import '../models/commons/acompaniantes_model.dart';

class ElegirIdentificacion extends StatefulWidget {
  Acompaniantes acompaniantes;
  Function(Acompaniantes) func;
  int posi;
  ElegirIdentificacion({
    @required this.posi,
    @required this.acompaniantes,
    @required this.func
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
  String name,image64B,image64F,nameItem ,fullImage;
  int index,idItem, posi;
  var config = ConfiguracionProvider();
  double width;
  bool _inProcess = false;
  TipoDoc _isSelect = null;
  ScanerModel _scanerModel = new ScanerModel();
  Acompaniantes acompaniantes;
  PMSBloc _pmsBloc;
  File imageB,imageF;
  Function(Acompaniantes) func;
  // Obtén una lista de las cámaras disponibles en el dispositivo.
  CameraController controller;
  Future<void> initializeControllerFuture;
  


  @override
  void initState() {
    _pmsBloc = new PMSBloc();
    posi = this.widget.posi;
    acompaniantes = this.widget.acompaniantes;
    func = this.widget.func;
    if (Platform.isAndroid) {
      Mrzflutterplugin.registerWithLicenceKey(config.configuracion.licenciaScaner);
    } else if (Platform.isIOS) {
      Mrzflutterplugin.registerWithLicenceKey(config?.configuracion?.licenciaScanerIos);
    }
    super.initState();
  }

  String _result = 'No result yet';
   List<TipoDoc> docList = [
    TipoDoc(
      index: 0,
      name: "pasaporte",
      short: "P",
      icon: Icon(FontAwesomeIcons.circle)
    ),
    TipoDoc(
      index: 1,
      short:"ID",
      name: "doc_identificacion",
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
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
    onWillPop: (){
      if(posi ==1){
        Navigator.pushReplacementNamed(context, 'infoTitular');
      }else if(posi ==2){
        Navigator.pushReplacementNamed(context, 'infoAdicional');
      }else if(posi ==3){
        Navigator.pushReplacementNamed(context, 'addHuesped');
      }
    },
    child:Stack(
        children: <Widget>[
          Scaffold(
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
          ),
          (_inProcess)?
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.5),
              child: Center(child: CircularProgressIndicator(),),
            )
          :Center()
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
          Container(
            width: MediaQuery.of(context).size.width-74,
            child: AutoSizeText(
              Translations.of(context).text('no_compartir'),
              style: greyText,
              maxLines: 2,
              maxFontSize: 25.0 ,
              minFontSize: 8.0 ,
            ),
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
            return  InkWell(
              onTap:(){
                nameItem = doc.name;
                idItem = item;
                _isSelect = doc;
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
              child: Container(
                width: MediaQuery.of(context).size.width-40,
                decoration: _decoration(),
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        Translations.of(context).text(doc.name),
                        style: greyText.copyWith(fontWeight: FontWeight.w700),
                      ),
                      trailing: InkWell(
                        onTap:(){
                            nameItem = doc.name;
                            idItem = item;
                            _isSelect = doc;
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
        style: greyText.copyWith(fontSize: 30, fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget _appbar() {
    return new AppBar(
      leading: Container(),
      title: Container(
        width: MediaQuery.of(context).size.width/2,
          child: AutoSizeText(
            Translations.of(context).text('doc_identificacion'),
            style: appbarTitle,
            maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 5.0 ,
          )
        ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              if(posi ==1){
                Navigator.pushReplacementNamed(context, 'infoTitular');
              }else if(posi ==2){
                Navigator.pushReplacementNamed(context, 'infoAdicional');
              }else if(posi ==3){
                 Navigator.pushReplacementNamed(context, 'addHuesped');
              }
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
          print('isTutular: '+acompaniantes.istitular.toString());
          print('idacompaniantes: '+acompaniantes.idacompaniantes.toString());
          print('IDACO: '+acompaniantes.idcliente.toString());
          print('Contains: '+_pmsBloc.acompaniantes.contains(acompaniantes).toString());
          
          
          if(_isSelect == null){
            Fluttertoast.showToast(
              msg: Translations.of(context).text('selec_tipo_doc'),
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
          style: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
      )
    );
  }

  _flujoId(){
    Alert(
      closeFunction:(){
        print('Se cerró la alerta');
      } ,
      context: context,
      image: Image.asset('assets/images/id_front.png'),
      title: '',
      content: Column(
        children: <Widget>[
        Container(
          height: 70,
          child: AutoSizeText(
            Translations.of(context).text('foto_titulo_uno'),
            style: greyText.copyWith(fontWeight: FontWeight.bold),
            //maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 10.0 ,
          )
        ),
        Container(
          height: 90,
          child: AutoSizeText(
            Translations.of(context).text('foto_body_uno'),
            style: greyText,
            //maxLines: 4,
            maxFontSize: 17.0 ,
            minFontSize: 10.0 ,
          )
        ),
        ],
      ),
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
            _pickImageF(ImageSource.camera);
            //_alertBackimage();
            //_idDocument();
          } ,
          child: Text(
            Translations.of(context).text('continuar'),
            style: lightBlueText.copyWith( fontSize: 20),
          ),
        )
      ]
    ).show();
  }

  _pickImageF(ImageSource source)async{
    this.setState(() {
      _inProcess =true;
    });
    File cropImage ;
    String base64;
    //LostDataResponse response = await ImagePicker.retrieveLostData();
    File ima = await ImagePicker.pickImage(source: source, imageQuality: 100,);
    if(ima != null){
        cropImage = await ImageCropper.cropImage(
        sourcePath: ima.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 0.6),
        compressQuality: 100,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: Translations.of(context).text('editar_imagen')
        ),
        iosUiSettings: IOSUiSettings(
          title: Translations.of(context).text('editar_imagen')
        )
      );
      List<int> imageBytes = await cropImage.readAsBytes();
      base64 = base64Encode(imageBytes);

      setState(() {
        image64F =base64;
        imageF = cropImage;
        acompaniantes.imagefront =image64F;
        _inProcess =false;
      });
      
      _alertBackimage();
    }else{
      this.setState(() {
        _inProcess =false;
      });
    }
    
  }

  _pickImageB(ImageSource source)async{
    this.setState(() {
      _inProcess =true;
    });
    File cropImage ;
    String base64;
    //LostDataResponse response = await ImagePicker.retrieveLostData();
    File ima = await ImagePicker.pickImage(source: source, imageQuality: 100,);
    if(ima != null){
        cropImage = await ImageCropper.cropImage(
        sourcePath: ima.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 0.6),
        compressQuality: 100,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: Translations.of(context).text('editar_imagen')
        ),
        iosUiSettings: IOSUiSettings(
          title: Translations.of(context).text('editar_imagen')
        )
      );
      List<int> imageBytes = await cropImage.readAsBytes();
      base64 = base64Encode(imageBytes);

      setState(() {
        image64B =base64;
        imageB = cropImage;
        acompaniantes.imageback =image64B;
        _inProcess =false;
        //func(acompaniantes);
      });
      
      _alertaFinId();
    }else{
      this.setState(() {
        _inProcess =false;
      });
    }
  }

  _alertBackimage(){
    Alert(
      closeFunction:(){
        print('Se cerró la alerta');
        //acompaniantes.imagefront = '';
        //acompaniantes.imageback = '';
      } ,
      context: context,
      image: Image.asset('assets/images/id_back.png'),
      title: '',
      content: Column(
        children: <Widget>[
        Container(
          height: 70,
          child: AutoSizeText(
            Translations.of(context).text('foto_titulo_dos'),
            style: greyText.copyWith(fontWeight: FontWeight.bold),
            //maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 10.0 ,
          )
        ),
        Container(
          height: 90,
          child: AutoSizeText(
            Translations.of(context).text('foto_body_dos'),
            style: greyText,
            //maxLines: 4,
            maxFontSize: 17.0 ,
            minFontSize: 10.0 ,
          )
        ),
        ],
      ),
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: ()async {
            Navigator.pop(context);
            _pickImageB(ImageSource.camera);
          } ,
          child: Text(
            Translations.of(context).text('continuar'),
            style: lightBlueText.copyWith( fontSize: 20),
          ),
        )
      ]
    ).show();
  }


  /* _idDocument () async {
    double width = MediaQuery.of(context).size.width;
    File file1 = await  Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => Camera(
            imageMask: Container(
              width:width,
              height: width*0.55,
                decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.grey.withAlpha(500) ),
              ), 
            ) 
          )
        )
      );

   List<int> imageBytes= await file1.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    setState(() {
      acompaniantes.imagefront = base64Image; 
    });
    log('file ${acompaniantes.imagefront}');
    debugPrint('file ${acompaniantes.imagefront}');

    Alert(
      closeFunction:(){
        print('Se cerró la alerta');
        acompaniantes.imagefront = '';
        acompaniantes.imageback = '';
      } ,
      context: context,
      image: Image.asset('assets/images/id_back.png'),
      title: '',
      content: Column(
        children: <Widget>[
        Container(
          height: 70,
          child: AutoSizeText(
            Translations.of(context).text('foto_titulo_dos'),
            style: greyText.copyWith(fontWeight: FontWeight.bold),
            //maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 10.0 ,
          )
        ),
        Container(
          height: 90,
          child: AutoSizeText(
            Translations.of(context).text('foto_body_dos'),
            style: greyText,
            //maxLines: 4,
            maxFontSize: 17.0 ,
            minFontSize: 10.0 ,
          )
        ),
        ],
      ),
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: ()async {
            Navigator.pop(context);
              File file2 = await  Navigator.push(context, MaterialPageRoute(builder: (context) => Camera(
                 imageMask: Container(
                    width:width,
                    height: width*0.55,
                    decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.grey.withAlpha(500) ),
                    ), 
                )
              )));
              List<int> imageBytes1= await file2.readAsBytes();
              String base64Image1 = base64Encode(imageBytes1);
              setState(() {
                acompaniantes.imageback = base64Image1; 
              });

              
              log('file ${acompaniantes.imageback}');
              debugPrint('file ${acompaniantes.imageback}');
            //_alertaFinId(file1,file2);
          } ,
          child: Text(
            Translations.of(context).text('continuar'),
            style: lightBlueText.copyWith( fontSize: 20),
          ),
        )
      ]
    ).show();
  } */

  _alertaFinId(){
    _inProcess =false;
    Alert(
      closeFunction:(){
        print('Se cerró la alerta');
       if(posi ==1){
          Navigator.pushReplacementNamed(context, 'infoTitular');
        }else if(posi ==2){
          Navigator.pushReplacementNamed(context, 'infoAdicional');
        }else if(posi ==3){
             Navigator.pushReplacementNamed(context, 'addHuesped');
          }
      } ,
      context: context,
      style: AlertStyle(titleStyle: greyText.copyWith(fontWeight:FontWeight.bold )),
      title: Translations.of(context).text('foto_fin_titulo'),
      content: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Image.file(imageF,height: 100,)
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Image.file(imageB,height: 100,)
          )
        ],
      ),
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: () {
            setState(() {
              Navigator.pop(context);
              _pmsBloc.acompaniantes = _pmsBloc.acompaniantes;
              if(posi ==1){
                Navigator.pushReplacementNamed(context, 'infoTitular');
              }else if(posi ==2){
                Navigator.pushReplacementNamed(context, 'infoAdicional');
              }else if(posi ==3){
                 Navigator.pushReplacementNamed(context, 'addHuesped');
              }
            });
            
          } ,
          child: Text(
            Translations.of(context).text('finalizar'),
            style: lightBlueText.copyWith( fontSize: 20),
          ),
        )
      ]
    ).show();
  }

  _flujopasaporte(){
    Alert(
      closeFunction:(){
        print('Se cerró la alerta');
      } ,
      context: context,
      image: Image.network('https://image.shutterstock.com/image-vector/vector-illustration-passport-biometric-data-260nw-761890669.jpg'),
      title: "",
      content: Container(
          height: 70,
          child: AutoSizeText(
            Translations.of(context).text('instruccion_scanner'),
            style: greyText.copyWith(fontWeight: FontWeight.w700),
            //maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 10.0 ,
          )
        ),
      buttons: [
        DialogButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
            startScanning();
          } ,
          child: Text(
            Translations.of(context).text('continuar'),
            style: lightBlueText.copyWith(fontSize: 20),
          ),
        )
      ]
    ).show();
    
  }

 /*  _takePhoto(int vuelta){
    return FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await initializeControllerFuture;
            final path = join( 
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            print("Path :  ");
            List<int> imageBytes= await  FileImage(File(path)).file.readAsBytes();
            String base64Image = base64Encode(imageBytes);
            acompaniantes.imagefront = base64Image; 
            print("imagen front : ${acompaniantes.imagefront}");
            _flujoId();
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
  } */

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
      acompaniantes.documenttype = _scanerModel.documentTypeReadable??'';
      acompaniantes.imagefront = _scanerModel?.full_image ??'';
      acompaniantes.imageback = _scanerModel?.portrait ??'';
      //func(acompaniantes);
      //acompaniantes.nombre = _scanerModel.givenNamesReadable;
      log('imagefront: ${acompaniantes.imagefront}');
    });
    (_scanerModel.documentTypeReadable!='' && acompaniantes.imagefront!='') 
    ?_alertScannerR() : 
    _alertNoFound(); 
  }

  _alertScannerR(){
    Uint8List bytes = base64.decode(acompaniantes.imagefront);
    return Alert(
        closeFunction:(){
          print('Se cerró la alerta');
          if(posi ==1){
            Navigator.pushReplacementNamed(context, 'infoTitular');
          }else if(posi ==2){
            Navigator.pushReplacementNamed(context, 'infoAdicional');
          }else if(posi ==3){
             Navigator.pushReplacementNamed(context, 'addHuesped');
          }
        } ,
        image: new Image.memory(bytes),
        context: context,
        title: '',
        content: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: AutoSizeText(
                Translations.of(context).text('fin_escaneo_titulo'),
                style: greyText.copyWith(fontWeight: FontWeight.bold),
                //maxLines: 2,
                maxFontSize: 25.0 ,
                minFontSize: 10.0 ,
              )
            ),
            Container(
              height: 90,
              child: AutoSizeText(
                Translations.of(context).text('fin_escaneo_body'),
                style: greyText.copyWith(fontWeight: FontWeight.w700),
                //maxLines: 4,
                maxFontSize: 17.0 ,
                minFontSize: 10.0 ,
              )
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              if(posi ==1){
                Navigator.pushReplacementNamed(context, 'infoTitular');
              }else if(posi ==2){
                Navigator.pushReplacementNamed(context, 'infoAdicional');
              }else if(posi ==3){
                 Navigator.pushReplacementNamed(context, 'addHuesped');
              }
            } ,
            child: Text(
              Translations.of(context).text('finalizar'),
              style: lightBlueText.copyWith(fontSize: 20),
            ),
          )
        ]
      ).show();
  }

  _alertNoFound(){
    return Alert(
        closeFunction:(){
          print('Se cerró la alerta');
          Navigator.pop(context);
        } ,
        context: context,
        title: '',
        content: Column(
          children: <Widget>[
            Container(
              height: 70,
              child: AutoSizeText(
                'No se encontró pasaporte',
                style: greyText.copyWith(fontWeight: FontWeight.bold),
                //maxLines: 2,
                maxFontSize: 25.0 ,
                minFontSize: 10.0 ,
              )
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              if(posi ==1){
                Navigator.pushReplacementNamed(context, 'infoTitular');
              }else if(posi ==2){
                Navigator.pushReplacementNamed(context, 'infoAdicional');
              }else if(posi ==3){
                 Navigator.pushReplacementNamed(context, 'addHuesped');
              }
            } ,
            child: Text(
              Translations.of(context).text('finalizar'),
              style: lightBlueText.copyWith(fontSize: 20),
            ),
          ),
          DialogButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              startScanning();
            } ,
            child: Text(
              Translations.of(context).text('intentar_nuevo'),
              style: lightBlueText.copyWith(fontSize: 20),
            ),
          ),
        ]
      ).show();
  }
}


