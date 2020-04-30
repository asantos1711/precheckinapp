import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class InformacionAdicional extends StatefulWidget {
  @override
  _InformacionAdicionalState createState() => _InformacionAdicionalState();
}

class _InformacionAdicionalState extends State<InformacionAdicional> {
  double width;
  double height;
  bool _promoInfoBool=false;
  bool _poliReglaBool=false;

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
        appBar: _appBar(),
        body: ListView(
            children: <Widget>[
              _promoInfo(),
              _poliRegla(),
              _signatureTitular(),
              _docuTitular(),
              _tituloAcompa(),
              _cardAcompa(),
            ],
          ),
      )
    );
  }

  Widget _cardAcompa(){
    Color _blue = Color.fromARGB(255,63, 90, 166);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: width,
            color: Colors.white,
            //decoration: _decoration(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: width-30,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "No. De Vuelo"
                    ),
                  )
                ),
                Container(
                  width: width-20,
                  child: Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: (width-30)/2,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Fecha de Salida"
                            ),
                          )
                        )
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: (width-30)/2,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Edad', style: TextStyle(fontWeight: FontWeight.w600),),
                              SizedBox(height: 5,),
                              Text('20 años')
                            ],
                          )
                        )
                      )
                    ],
                  )
                ),
              ],
            )
          ),
          _signatureTitular(),
          Container(
            color: Colors.white,
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
          )
        ],
      )
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
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,color: Colors.grey
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(0.0) //         <--- border radius here
              ),
            ),
            child: Signature(
              controller: _controller, 
              height :100,
              width: width-20,
              backgroundColor: Colors.white
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                  child: Text('Limpiar')
                )
              ],
            ),
          ),
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