import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewPoliRegla extends StatefulWidget {
  @override
  _ViewPoliReglaState createState() => _ViewPoliReglaState();
}

class _ViewPoliReglaState extends State<ViewPoliRegla> {
  ScrollController _scrollController = new ScrollController();
  double width;
  @override
  Widget build(BuildContext context) {
    
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: ListView(
        controller: _scrollController,
        children: <Widget>[
        _subir(),
        ],
      ),
    );
  }

  Widget _subir(){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width: width,
      alignment: Alignment.center,
      child: MaterialButton(
        onPressed: () {
          _scrollController.animateTo(_scrollController.position.minScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
        },
        color: Colors.blue,
        textColor: Colors.white,
        child: Icon(
          FontAwesomeIcons.arrowCircleUp,
          size: 24,
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      )
    );
  }
  _appBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text('Politicas y Reglamento'),
    );
  }
}