import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChooseLanguage.dart';


// launcher page > a simple rotation animation

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  AnimationController _controller;
  Animation<Offset> _offsetFloat; 
afterSplash() {
    var duration = Duration(milliseconds: 3000);
    return Timer(duration, nextPage);
  }


  // choosing which page to go
  void nextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => 
          ChooseLanguage()
          //x == 0 ? IntroPage() : NavBar(),
        ));
  }

  int x = 0;

  //checking which page open first
  _checkPage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int _x = sp.getInt('x') ?? 0;
    setState(() {
      x = _x;
    });
  }
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _offsetFloat = Tween<Offset>(begin: Offset(1.8, 0.0), end: Offset(0.0,0.0))
        .animate(_controller);

    _offsetFloat.addListener((){
      setState((){});
    });

    _controller.forward();
    
    afterSplash();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height100 = MediaQuery.of(context).size.height;
    double width100 = MediaQuery.of(context).size.width;
    return new SlideTransition(
      position: _offsetFloat,
      child: OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment(0.0,0.0),
        child: Image.asset(
          "assets/images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width*5,
          fit: BoxFit.fitHeight,
        ),
      )
    );
  }
  /* AnimationController _controller;


  // when animation is completed
  afterSplash() {
    var duration = Duration(milliseconds: 2000);
    return Timer(duration, nextPage);
  }


  // choosing which page to go
  void nextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => 
          ChooseLanguage()
          //x == 0 ? IntroPage() : NavBar(),
        ));
  }

  int x = 0;

  //checking which page open first
  _checkPage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int _x = sp.getInt('x') ?? 0;
    setState(() {
      x = _x;
    });
  }

  @override
  void initState() {
    _checkPage();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.forward();
    
    
    afterSplash();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SlideTransition(
              position:Tween<Offset>(begin: Offset(0.0, -0.8), end: Offset.zero).animate() ,
              //turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: Image(
                image: AssetImage('assets/images/mex_circle.png'),
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              )
            ),
    ));
  } */
}
