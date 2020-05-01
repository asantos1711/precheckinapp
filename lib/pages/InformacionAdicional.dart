import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/pages/ViewPoliRegla.dart';
import 'package:precheckin/pages/ViewPromoInfo.dart';
import 'package:precheckin/widgets/card_acompanante.dart';
import 'package:precheckin/widgets/check_text_bold.dart';
import 'package:precheckin/widgets/custom_signature.dart';
import 'package:signature/signature.dart';

class InformacionAdicional extends StatefulWidget {
  @override
  _InformacionAdicionalState createState() => _InformacionAdicionalState();
}

class _InformacionAdicionalState extends State<InformacionAdicional> {
  double width;
  double height;
  bool _promoInfoBool=false;
  bool _recibirInfoBool=false;
  bool _poliReglaBool=false;
  DateTime dateAco = new DateTime.now();
  TextEditingController textController = new TextEditingController(text: ''); 

  final SignatureController _controller = SignatureController(penStrokeWidth: 5, penColor: Colors.red);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  _changePromoInfo(){
    setState(() {
      _promoInfoBool=!_promoInfoBool;
    });
  }
  _changeRecibirInfo(){
    setState(() {
      _recibirInfoBool=!_recibirInfoBool;
    });
  }
  _changePoliRegla(){
    setState(() {
      _poliReglaBool=!_poliReglaBool;
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
      child:Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: ListView(
            children: <Widget>[
              _promoInfo(),
              _poliRegla(),
              _signatureTitular(),
              _docuTitular(),
              _tituloAcompa(),
              _acompanantes(),
              _agregarAco(),
              Divider(height: 2,color: Colors.grey,),
              _recibirInfo(),
              _buttonFinalizar(),
              SizedBox(height: 50,)
            ],
          ),
      )
    );
  }

  
  Widget  _buttonFinalizar(){
    return Container(
      width: width-20,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      color: Colors.white,
      child:FlatButton(
        color: Colors.deepOrange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.grey,
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => InformacionAdicional(),
            )
          );
        },
        child: Text(
          "Finalizar",
          style: TextStyle(fontSize: 20.0),
        ),
      )
    );
  }

  Widget _agregarAco(){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width: width,
      alignment: Alignment.center,
      child: MaterialButton(
        onPressed: () {},
        color: Colors.blue,
        textColor: Colors.white,
        child: Icon(
          FontAwesomeIcons.plus,
          size: 24,
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      )
    );
  }

  Widget _recibirInfo(){
    return Container(
      //color: Colors.white,
      margin: EdgeInsets.only(top:10),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 50,
            child: Checkbox(
              activeColor: Colors.blue,
              value: _recibirInfoBool,
              onChanged: (bo){
                _changeRecibirInfo();
              }
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 5),
            width: width-50,
            child: Text('Estoy de acuerdo en recibir información y promociones de nuestro Club Vacacional de manera electrónica y/o telefónica',),
          )
        ],
      )
    );
  }


  Widget _acompanantes(){
    return Column(
      children: <Widget>[
        Container(
          child: CardAcompanante(
            controllerText: textController,
            date: dateAco,
            signature: CustomSignature(
              controller: _controller,
            ),
          )
        ),
         Container(
          child: CardAcompanante(
            date: dateAco,
            controllerText: textController,
            signature: CustomSignature(
              controller: _controller,
            ),
          )
        ) 
      ],
    );
  }

  Widget _tituloAcompa(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, right: 10),
      width: width-20,
      child: Text('Acompañantes', style: TextStyle(fontSize: 25,),)
    );
  }

  Widget _docuTitular(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, right: 10),
      width: width-20,
      child:Row(
        children: <Widget>[
          Container(
            width: ((width-20)/3)*2,
            child: Text('Documento de identificación',style: TextStyle(color: Colors.blueAccent,fontSize: 18),)
          ),
          Container(
            alignment: Alignment.centerRight,
            width: (width-20)/3,
            child: Icon(Icons.camera_alt, color: Colors.deepOrange,size: 30,)
          )
        ],
      )
    );
  }

  Widget _poliRegla(){
    return Container(
      color: Colors.white,
      //padding: EdgeInsets.all(5),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 40,
            child: Checkbox(
              activeColor: Colors.blue,
              value: _poliReglaBool,
              onChanged: (bo){
                _changePoliRegla();
              }
            ),
          ),
          Container(
            width: width-40,
            child: RichText(text: TextSpan(
              text: "Acepto y estoy de acuerdo con las ",
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: 'políticas y el reglamento del hotel',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(context,
                    PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => ViewPoliRegla(),
                      )
                    );
                  }
                )
              ]
            ),),
          )
        ],
      )
    );
  }

  Widget _promoInfo(){
    /* return CheckTextBold(
      checkbox:Checkbox(
        activeColor: Colors.blue,
        value: _promoInfoBool,
        onChanged: (bo){
          _changePromoInfo();
        }
      ),
      text:'Acepto y autorizo el uso de mi correo para  ' ,
      textBold: 'promociones e información',
      onTap: (){
        Navigator.push(
        context,
        PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ViewPromoInfo(),
          )
        );
      },
    ); */
    return Container(
      color: Colors.white,
      //padding: EdgeInsets.all(5),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: 40,
            child: Checkbox(
              activeColor: Colors.blue,
              value: _promoInfoBool,
              onChanged: (bo){
                _changePromoInfo();
              }
            ),
          ),
          Container(
            width: width-40,
            child: RichText(text: TextSpan(
              text: "Acepto y autorizo el uso de mi correo para ",
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: 'promociones e información',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(context,
                    PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => ViewPromoInfo(),
                      )
                    );
                  }
                )
              ]
            ),),
          )
        ],
      )
    ); 
  }

  Widget _signatureTitular(){
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10),
            child: Text('Ingresa firma de titular', style: TextStyle(fontSize: 20),)
          ),
          CustomSignature(
            controller: _controller,
          )
        ],
      )
    );
  }

  Widget _appBar(){
    return AppBar(
      backgroundColor: Colors.deepOrange,
      leading: Container(),
      title:Text('Información de reservación') ,
    );
  }
}