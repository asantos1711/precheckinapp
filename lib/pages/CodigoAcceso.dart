import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/pages/HabitacionTitular.dart';
import 'package:precheckin/providers/pms_provider.dart';
import 'package:precheckin/tools/translation.dart';

class CodigoAcceso extends StatefulWidget {
  String language;
  CodigoAcceso(this.language);
  @override
  _CodigoAccesoState createState() => _CodigoAccesoState();
}

class _CodigoAccesoState extends State<CodigoAcceso> {
  final formKey = GlobalKey<FormState>();
  double height;
  double width;
  double space;
  String _language;
  TextEditingController _codigoController;

  @override
  void initState() {
    _language = this.widget.language;
    _codigoController = new TextEditingController(text: "2114607",);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    space =height/6;

    return Stack(
      children: <Widget>[
        Image.asset(
            "assets/images/background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: <Widget>[
              SizedBox(height: space,),
              _logo(),
              _bandera(),
              _textoIngresa(),
              _textField(),
              _ingresar()
          ],
        )
      )
      ],
    );
  }

  Widget _ingresar(){
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            splashColor: Color.fromARGB(100, 255,255,255),
            onTap: (){
              _showReserva(context);
            },
            child: Container(
              child: Text(
                Translations.of(context).text('btn_ingresar'), 
                style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)
              )
            )
          )
        ]
      )
    ); 
  }

  Future _showReserva(BuildContext contex) async {
    PMSProvider provider = new PMSProvider(); //Provide PMS Services
    Reserva infoReserva = await provider.dameReservacion(hotel: "0", idreserva: _codigoController.text);
    Navigator.pushNamed(context, 'reserva',arguments: infoReserva.result); //Navegacion por nombre pasando argumentos.
  }

  Widget _textField(){
    return  Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(100, 255, 255, 255),
                    borderRadius:BorderRadius.circular(20),
                  ),
                  width: width-40,
                  child: TextField(
                    controller: _codigoController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white)
                      ),
                    ),
                  ),
                )
              ]
            )
          );
  }

  Widget _textoIngresa(){
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Translations.of(context).text('txt_ingresar'), 
            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)
          )
        ]
      )
    );
  }

  Widget _bandera(){
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            splashColor: Colors.blue.withAlpha(70),
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle
              ),
              child: _imagenBandera(),
            )
          ),
        ],
      )
    );
  }

  Widget _imagenBandera(){
    if(_language == 'es')
      return Image.asset('assets/images/mex_circle.png');
    else if(_language == 'en')
      return Image.asset('assets/images/usa_circle.png');
  }

  Widget _logo(){
    return SvgPicture.asset(
      'assets/images/sunset_logo.svg',
      semanticsLabel: 'Acme Logo',
      color: Colors.white,
    );
  }
}