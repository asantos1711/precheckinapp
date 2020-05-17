import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewWebView extends StatefulWidget {
  String mostrar;
  String title;
  ViewWebView({
    @required this.mostrar,
    @required this.title
  });
  @override
  _ViewWebViewState createState() => _ViewWebViewState();
}

class _ViewWebViewState extends State<ViewWebView> {
  ScrollController _scrollController = new ScrollController();
  Completer<WebViewController> _controller = Completer<WebViewController>();
  double width;
  String mostrar;
  String title;

  @override
  void initState() {
    // TODO: implement initState
    mostrar = this.widget.mostrar;
    title = this.widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      //extendBodyBehindAppBar: true,
      //backgroundColor: Colors.white,
      appBar: _appBar(),
      body:   _contenido(), 
    ); 
  }

  Widget _contenido(){
    /* return Html(
      data: """<div>Hola</div>""",
    ); */
  }

  _appBar(){
    String _t = title[0].toUpperCase()+title.substring(1);
    return AppBar(
      title:Container(
        width: MediaQuery.of(context).size.width/2,
          child: AutoSizeText(
            _t,
            style: appbarTitle,
            maxLines: 1,
            maxFontSize: 25.0 ,
            minFontSize: 5.0 ,
          )
        ),
      centerTitle: true,
    );
  }
}