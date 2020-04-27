import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precheckin/pages/HabitacionTitular.dart';

class CodigoAcceso extends StatefulWidget {
  @override
  _CodigoAccesoState createState() => _CodigoAccesoState();
}

class _CodigoAccesoState extends State<CodigoAcceso> {
  final formKey = GlobalKey<FormState>();
  double height;
  double width;
  double space;
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
              Navigator.push(
                context, 
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => HabitacionTitular(),
                )
              );
            },
            child: Container(
              child: Text(
                'Ingresar', 
                style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)
              )
            )
          )
        ]
      )
    ); 
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
            'Ingrese su código de acceso', 
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
            onTap: (){},
            splashColor: Colors.blue.withAlpha(70),
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle
              ),
              child: Image.asset('assets/images/mex_circle.png'),
            )
          ),
        ],
      )
    );
  }

  Widget _logo(){
    return SvgPicture.asset(
      'assets/images/sunset_logo.svg',
      semanticsLabel: 'Acme Logo',
      color: Colors.white,
    );
  }
}