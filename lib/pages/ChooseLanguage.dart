import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/tools/application.dart';
import 'package:precheckin/tools/translation.dart';

import 'CodigoAcceso.dart';

class ChooseLanguage extends StatefulWidget {
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  QRPersistence _persitence = new QRPersistence();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double space =height/6;

    
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
                    _banderas(),
                ],
              )
            )
            ],
          );
    
  }

  Widget _banderas(){
    return Container(
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: (){
              applic.onLocaleChanged(new Locale('en',''));


              if(_persitence.qr.isNotEmpty){

                Navigator.pushNamed(context, 'codigosQR', arguments: _persitence.qr);

              } else {

                Navigator.push(
                context, 
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => CodigoAcceso('en'),
                )

                );  
              }

            },
            splashColor: Colors.blue.withAlpha(70),
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle
              ),
              child: Image.asset('assets/images/usa_circle.png'),
            )
          ),
          InkWell(
            onTap: (){
              applic.onLocaleChanged(new Locale('es',''));

              if(_persitence.qr.isNotEmpty){

                Navigator.pushNamed(context, 'codigosQR', arguments: _persitence.qr);

              } else {

                Navigator.push(
                  context, 
                  PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => CodigoAcceso('es'),
                  )
                );  

              }
            },
            splashColor: Colors.blue.withAlpha(70),
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle
              ),
              child: Image.asset('assets/images/mex_circle.png'),
            )
          )
          ,
          
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