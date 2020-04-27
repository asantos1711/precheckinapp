import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:precheckin/pages/CodigoAcceso.dart';

class ChooseLanguage extends StatefulWidget {
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
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
              _banderas()
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
              Navigator.push(
                context, 
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => CodigoAcceso(),
                )
              );
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
              Navigator.push(
                context, 
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => CodigoAcceso(),
                )
              );
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