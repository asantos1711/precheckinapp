import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/pages/ElegirIdentificacion.dart';
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/preferences/user_preferences.dart';
import 'package:precheckin/providers/pms_provider.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/card_acompanante.dart';
import 'package:precheckin/widgets/check_text_bold.dart';
import 'package:precheckin/widgets/custom_signature.dart';
import 'package:precheckin/widgets/docIdentificacion.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:signature/signature.dart';
import 'package:precheckin/utils/tools_util.dart' as tools;

import 'ViewWebView.dart';


import 'package:precheckin/widgets/signature_widget.dart';

class InformacionAdicional extends StatefulWidget {
  Reserva reserva;
  Result result;
  
  InformacionAdicional({
    @required this.reserva,
    @required this.result
  });

  @override
  _InformacionAdicionalState createState() => _InformacionAdicionalState();
}

class _InformacionAdicionalState extends State<InformacionAdicional> {
  double width;
  double height;
  bool _enableButton = true;
  bool _promoInfoBool = true;
  bool _avisoPrivaBool = true;
  bool _recibirInfoBool = true;
  bool _poliReglaBool = true;
  bool _bloquear = false;
  int cant_adultos, cant_menores;
  QRPersistence _persistence = new QRPersistence();
  List<String> _qr;

  DateTime dateAco = new DateTime.now();
  TextEditingController textController = new TextEditingController(text: '');
  Reserva _reserva;  
  Result _result;  
  Map<Acompaniantes,SignatureController> mapControllerSiganture = Map<Acompaniantes,SignatureController>();

  final SignatureController _controller = SignatureController();
  UserPreferences _pref = new UserPreferences();



  @override
  void initState() {
    super.initState();
    _controller.addListener((){});

    _qr = _persistence.qr;
    _reserva = this.widget.reserva;
    _result = this.widget.result;
  }

  _botonDisable(){
    setState(() {
      _enableButton = _poliReglaBool && _promoInfoBool & _avisoPrivaBool ;
    });
  }

  @override
  Widget build(BuildContext context) {
    

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  _promoInfo(),
                  _poliRegla(),
                  _signatureTitular(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DocIdentificacion(acompaniantes: _result.titular,)
                  ),
                  _tituloAcompa(),
                  _acompanantes(),
                  _agregarAco(),
                  Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                  _avisoPriva(),
                  _recibirInfo(),
                  _buttonFinalizar(),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
              tools.bloqueaPantalla(_bloquear)

            ],
          )
          
          
        ));
  }


  //Agrega la firma del titular
  Widget _signatureTitular() {
    _controller.addListener(() async {
        var data = await _controller.toPngBytes();
        _result.titular.imagesign = base64.encode(data);
    });

    return Container(
      margin: EdgeInsets.symmetric(vertical:10.0, horizontal:10.0),
      child: SignatureWidget(
        img:_result.titular.imagesign ?? "",
        title:Translations.of(context).text('ingresa_firma_titular'),
        controller: _controller,
      ),
    );
  }

 

  Widget _buttonFinalizar() {
    return Container(
      width: width - 20,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      color: Colors.white,
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.grey,
        onPressed: _enableButton == false ? null : () =>_saveData(),
        child: Text(
          Translations.of(context).text('finalizar'),
          style: TextStyle(fontSize: 20.0),
        ),
      ));
  }

  Future _saveData() async {
    _bloquearPantalla(true);
    
    PMSProvider p = new PMSProvider();
    bool status = await p.actualizaHospedaje(_result);

    _bloquearPantalla(false);

    if(status) {

      if(!_pref.tieneLigadas) {
        if(!_qr.contains(_reserva.codigo))
          _qr.add(_reserva.codigo);

        _persistence.qr = _qr;

        Navigator.pushNamed(context, "verQR", arguments: _reserva.codigo);
      } else {
        List<String> l = _pref.ligadas;
        l.remove(_result.idReserva.toString());
        _pref.ligadas = l;

        Navigator.pushNamed(context, 'litaReserva', arguments: _reserva);
      }



    }
    else {
      tools.showAlert(context, "No se logro guardar los datos");
    }

  }


  void _bloquearPantalla(bool status){
    _bloquear = status;
      setState(() {});
  }

  Widget _agregarAco() {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: width,
        alignment: Alignment.center,
        child: MaterialButton(
          onPressed: () {
            setState(() {
              //Para verificar la densidad
              if(_condicionAgregarAcom('0')){
                _onAlertWithCustomContentPressed(context);
              }
            });
          },
          color: Colors.blue,
          textColor: Colors.white,
          child: Icon(
            FontAwesomeIcons.plus,
            size: 24,
          ),
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        ));
  }

  
  bool _condicionAgregarAcom(String nuevaEdad){
    int adultos = 1;//inicio en 1 por el titular
    int menores=0;
    int densiadultos = 1;//inicio en 1 por el titular
    int densimenores=0;
    int edad;
    int _nuevaEdad = int.parse(nuevaEdad);
    _reserva.result.acompaniantes.forEach((element) { 
      edad =int.parse(element.edad);
      if(edad<18){
        menores++;
      }else if(edad>=18){
        adultos++;
      }
    });
    print("Adultos:  $adultos");
    print("Menore:  $menores");

    double densidadTotal  = double.parse(_reserva.result.tipoHabitacion.densidad) ;
    densiadultos = densidadTotal.floor();
    densimenores = ((densidadTotal-densiadultos)*10).floor();

    print('desnsidad ${_reserva.result.tipoHabitacion.densidad}');
    print("densiAdultos:  $densiadultos");
    print("densiMenore:  $densimenores");

    if(adultos>= densiadultos && menores>=densimenores){
      print("no se puede agregar acompañante");
      _toast( "Haz alcanzado el máximo de acompañantes");
      return false;
    }


    if(_nuevaEdad<18){
      menores++;
      if(menores <= densimenores){
        print("se puede agregar menor ");

        return true;
      }else{
        print("no se puede agregar menor");
        _toast( "Haz alcanzado el máximo de acompañantes menores");
        return false;
      }
    }else if(_nuevaEdad>=18){
      adultos++;
      if(adultos <= densiadultos){
        print("se puede agregar mayor");
        return true;
      }else{
        print("no se puede agregar mayor");
        _toast( "Haz alcanzado el máximo de acompañantes adultos");
        return false;
      }
    }

  }

  Widget _toast(String text){
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 20.0
    );
  }


  Widget _recibirInfo() {
    return CheckTextBold(
        width: width,
        onChange:(boo){
          setState(() {
            _recibirInfoBool = !_recibirInfoBool;
          });
        } ,
        textBold: '',
        text:
          Translations.of(context).text('recibir_info'),
        onTap: () {},
        value: _recibirInfoBool
    );
  }

  Widget _acompanantes() {
    return Column(
      children: _listaAcompaniantes(),
    );
  }

_onAlertWithCustomContentPressed(context) {
    Acompaniantes _aco = new Acompaniantes();
    _aco.fechanac = new DateTime.now().toString();
    _aco.club = _result.idClub;
    _aco.idcliente = _result.idCliente;
    _aco.idacompaniantes = 0;
    _aco.istitular = false;
    
    SignatureController _sigController = new SignatureController();
    _sigController.addListener(() async {
        var data = await _sigController.toPngBytes();
        _aco.imagesign = base64.encode(data);
    });
    Alert(
        closeFunction:(){
          print('Se cerró la alerta');
        } ,
        context: context,
        title: "Agregar acompañante",
        content: Column(
          children: <Widget>[
            CardAcompanante(
              acompaniante: _aco,
              signature: CustomSignature(
                controller: _sigController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(FontAwesomeIcons.exclamationCircle , color: Colors.red,size: 15, ),
                Expanded(
                  child: Text(
                    Translations.of(context).text('cargo')+''+Translations.of(context).text('cargo_valor'), 
                    style: TextStyle(color: Colors.red, fontSize: 15),
                    maxLines: 2,
                    ),  
                )
              ],
            )
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.white,
            onPressed: () {
              setState(() {
                
                if(_condicionAgregarAcom(_aco.edad)){
                  mapControllerSiganture[_aco] =_sigController;
                  _aco.istitular = false;
                  _result.acompaniantes.add(_aco);
                  mapControllerSiganture[_aco] =_sigController;
                }
                
              });
              Navigator.pop(context);
              if(_condicionAgregarAcom(_aco.edad))
                Fluttertoast(

                );
            } ,
            child: Text(
              Translations.of(context).text('agregar'),
              style: TextStyle(color: Colors.blueAccent, fontSize: 20),
            ),
          )
        ]).show();
  }

  /*
  Forma un Widgtet CardAcompaniantes por
  cada uno de los acompaniantes que bienen
  del servicio.
  */
  List<Widget> _listaAcompaniantes() {
    List<Widget> widgets = [];

    _result.acompaniantes.forEach( (acompaniante){
      SignatureController _controllerSignature = new SignatureController();

      _controllerSignature.addListener(()async{
        var data = await _controllerSignature.toPngBytes();
        acompaniante.imagesign = base64.encode(data);
      });
      acompaniante.imagefront = null;
      Widget widget = CardAcompanante(
        acompaniante: acompaniante,
        signature:  Container(
          margin: EdgeInsets.symmetric(vertical:10.0, horizontal:10.0),
          child: SignatureWidget(
            img: acompaniante.imagesign ?? "",
            title:"",
            controller: _controllerSignature,
          )
        )
      );

      widgets..add(widget);

    } );
    
    return widgets;
  }

  

  Widget _tituloAcompa() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10),
        width: width - 20,
        child: Text(
          Translations.of(context).text('acompanantes'),
          style: TextStyle(
            fontSize: 25,
          ),
        ));
  }

  Widget _docuTitular() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10),
        width: width - 20,
        child: Row(
          children: <Widget>[
            Container(
                width: ((width - 20) / 3) * 2,
                child: Text(
                  'Documento de identificación',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                )),
            Container(
                alignment: Alignment.centerRight,
                width: (width - 20) / 3,
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => ElegirIdentificacion(
                          acompaniantes: _reserva.result.titular,
                        ),
                      )
                    );
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Color(0xFFE87200),
                    size: 30,
                  )
                )
              )
          ],
        ));
  }

  Widget _poliRegla() {
    return CheckTextBold(
      width: width,
      onChange:(boo){
        setState(() {
          _poliReglaBool = !_poliReglaBool;
        });
        _botonDisable();
      } ,
      value: _poliReglaBool,
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('politicas_procedimientos'),
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: 
              (context, animation1, animation2) => 
              ViewWebView(
                url: 'https://www.google.com/',
                title:Translations.of(context).text('politicas_procedimientos'),
              ),
            ));
      },
    );
  }

  Widget _promoInfo() {
    return CheckTextBold(
      width: width,
      onChange:(boo){
        setState(() {
          _promoInfoBool = !_promoInfoBool;
        });
        _botonDisable();
      } ,
      value: _promoInfoBool,
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('reglamento_hotel'),
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: 
              (context, animation1, animation2) => 
              ViewWebView(
                url: 'https://www.sunsetworldresorts.com/es/resorts/hacienda-tres-rios-resort-spa-nature-park/politica-de-privacidad/',
                title: Translations.of(context).text('reglamento_hotel'),
              ),
            ));
      },
    );
  }

  Widget _avisoPriva() {
    return CheckTextBold(
      width: width,
      onChange:(boo){
        setState(() {
          _avisoPrivaBool = !_avisoPrivaBool;
        });
        _botonDisable();
      } ,
      value: _avisoPrivaBool,
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('aviso_privacidad'),
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => 
              ViewWebView(
                url:'https://www.google.com/',
                title: Translations.of(context).text('aviso_privacidad'),
              ),
            ));
      },
    );
  }

 

  Widget _appBar() {
    return AppBar(
      leading: Container(),
      title: Text(Translations.of(context).text('info_reservacion'),style: appbarTitle),
      centerTitle: true,
    );
  }
}
