import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/pages/ElegirIdentificacion.dart';
import 'package:precheckin/pages/ViewPoliRegla.dart';
import 'package:precheckin/pages/ViewPromoInfo.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/card_acompanante.dart';
import 'package:precheckin/widgets/check_text_bold.dart';
import 'package:precheckin/widgets/custom_signature.dart';
import 'package:precheckin/widgets/docIdentificacion.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:signature/signature.dart';

class InformacionAdicional extends StatefulWidget {
  @override
  _InformacionAdicionalState createState() => _InformacionAdicionalState();
}

class _InformacionAdicionalState extends State<InformacionAdicional> {
  double width;
  double height;
  bool _promoInfoBool = false;
  bool _avisoPrivaBool = false;
  bool _recibirInfoBool = false;
  bool _poliReglaBool = false;
  DateTime dateAco = new DateTime.now();
  TextEditingController textController = new TextEditingController(text: '');
  Reserva _reserva;  
  Map<Acompaniantes,SignatureController> mapControllerSiganture = Map<Acompaniantes,SignatureController>();



  final SignatureController _controller =
      SignatureController(penStrokeWidth: 5, penColor: Colors.red);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    _reserva = ModalRoute.of(context).settings.arguments;
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
          body: ListView(
            children: <Widget>[
              _promoInfo(),
              _poliRegla(),
              _signatureTitular(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DocIdentificacion()
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
        ));
  }

  Widget _buttonFinalizar() {
    return Container(
        width: width - 20,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        color: Colors.white,
        child: FlatButton(
          color: Color(0xFFE87200),
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.grey,
          onPressed: (){
            try{
              /* mapControllerSiganture.forEach((key, value){
                SignatureController c = value;
                FutureBuilder(
                  future:  c.toPngBytes(),
                  builder: (BuildContext c,AsyncSnapshot<Uint8List> v){
                    setState((){  
                      var data = v.data;
                      key.imagesign = base64.encode(data);
                    });
                });
              }); */
              setState((){
                _reserva.result.acompaniantes.forEach( (acompaniante){
                  print("Acompañante----");
                  print("Fecha Nac:${acompaniante.fechanac.toString()}");
                  print("Edad:${acompaniante.edad.toString()}");
                  print("Nombre:${acompaniante.nombre.toString()}");
                  print("Firma:${acompaniante.imagesign.toString()}");
                });
                print('_poliReglaBool '+_poliReglaBool.toString());            /*  */
                print('_poliReglaBool '+_promoInfoBool.toString());            /*  */
                print('_recibirInfoBool '+_recibirInfoBool.toString());            /*  */
                print('_avisoPrivaBool '+_avisoPrivaBool.toString());   
              });
            } catch (e){
              print("No fue posible obtener la información de la reservación!. Se genero la siguinte excepcion:\n$e");
            };
          },
          child: Text(
            "Finalizar",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
  }

  Widget _agregarAco() {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        width: width,
        alignment: Alignment.center,
        child: MaterialButton(
          onPressed: () => _onAlertWithCustomContentPressed(context),
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
            'Estoy de acuerdo en recibir información y promociones de nuestro Club Vacacional de manera electrónica y/o telefónica',
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
    print("Alerta fecha "+_aco.fechanac);
    SignatureController _sigController = new SignatureController();
    Alert(
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
              children: <Widget>[
                Icon(FontAwesomeIcons.exclamationCircle , color: Colors.red,size: 15, ),
                Text(
                  Translations.of(context).text('cargo')+''+Translations.of(context).text('cargo_valor'), 
                  style: TextStyle(color: Colors.red, fontSize: 15),)
              ],
            )
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.white,
            onPressed: () {
              setState(() {
                mapControllerSiganture[_aco] =_sigController;
                //mapControllerSiganture[_aco].points = _sigController.points ;
                //print(( _sigController.points.toList().toString()));
                //print((mapControllerSiganture[_aco].points.toList().toString()));
                //print(( _sigController.points.toList().toString()==mapControllerSiganture[_aco].points.toList().toString()));
                _reserva.result.acompaniantes.add(_aco);
              });
              Navigator.pop(context);
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
  List<Widget> _listaAcompaniantes(){
    List<Widget> widgets = [];

    _reserva.result.acompaniantes.forEach( (acompaniante){
      SignatureController _controllerSignature = new SignatureController();
      mapControllerSiganture[acompaniante] = _controllerSignature;
      mapControllerSiganture[acompaniante].addListener(()async{
        print('Change value');
        var data = await mapControllerSiganture[acompaniante].toPngBytes();
        acompaniante.imagesign = base64.encode(data);
        print('Value ${acompaniante.nombre}: ${acompaniante.imagesign}');
      });
      Widget widget = CardAcompanante(
          acompaniante: acompaniante,
          signature: CustomSignature(
            acompaniantes: acompaniante,
            controller: _controllerSignature,
          ),
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
                        pageBuilder: (context, animation1, animation2) => ElegirIdentificacion(),
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
        _poliReglaBool = !_poliReglaBool;
      } ,
      value: _poliReglaBool,
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('politicas_procedimientos_bold'),
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ViewPoliRegla(),
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
      } ,
      value: _promoInfoBool,
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('reglamento_hotel_bold'),
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ViewPromoInfo(),
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
      } ,
      value: _avisoPrivaBool,
      text: 'Acepto y estoy de acuerdo con el ',
      textBold: 'aviso de privacidad',
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ViewPromoInfo(),
            ));
      },
    );
  }

  Widget _signatureTitular() {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  Translations.of(context).text('ingresa_firma_titular'),
                  style: TextStyle(fontSize: 20),
                )),
            CustomSignature(
              controller: _controller,
            )
          ],
        ));
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor:  Color(0xFFE87200),
      leading: Container(),
      title: Text('Información de reservación'),
    );
  }
}
