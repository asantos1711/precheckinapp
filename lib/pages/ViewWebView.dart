import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_textview_render/html_text_view.dart';
import 'package:precheckin/models/commons/politicas_model.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:webview_flutter/webview_flutter.dart';




class ViewWebView extends StatefulWidget {
  List<Politicas> politicas;
  String title;
  String valor;
  ViewWebView({
    @required this.politicas,
    @required this.title,
    @required this.valor
  });
  @override
  _ViewWebViewState createState() => _ViewWebViewState();
}

class _ViewWebViewState extends State<ViewWebView> {
  ScrollController _scrollController = new ScrollController();
  Completer<WebViewController> _controller = Completer<WebViewController>();
  double width;
  List<Politicas> politicas;
  String title;
  String valor;
  String dataHtml;

  @override
  void initState() {
    politicas = this.widget.politicas;
    valor = this.widget.valor;
    title = this.widget.title;
    //_dataHtml();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dataHtml();
     return Scaffold(
      //extendBodyBehindAppBar: true,
      //backgroundColor: Colors.white,
      appBar: _appBar(),
      floatingActionButton: _floatButton(),
      body:   new ListView(
        controller: _scrollController,
        children: <Widget>[
          _contenido()
        ],
      ), 
    ); 
  }

   _floatButton(){
     return FloatingActionButton(
        onPressed: () =>  _scrollController.jumpTo(_scrollController.position.minScrollExtent),
        child: Icon(Icons.arrow_upward),
     );
   }

   _dataHtml(){
    Politicas poli;
    String l;
    print("Translations:"+Translations.of(context).locale.toLanguageTag());
    l=Translations.of(context).locale.toLanguageTag();
    if(l.contains('ES')){
     poli = politicas.elementAt(0);
    }else if(l.contains('EN')){
      poli = politicas.elementAt(1);
    }

    switch (valor) {
      case 'reglamento_hotel':
          dataHtml = """<div>${poli.seg_acu_reg}</div>""";
        break;
      case 'aviso_privacidad':
          dataHtml = """<div>${poli.seg_avi_priv}</div>""";
        break;
      case 'politicas_procedimientos':
          dataHtml = """<div>${poli.seg_obj_dej}</div>""";
          dataHtml += """<div>${poli.seg_acu_est}</div>""";
          dataHtml += """<div>${poli.seg_san_amb}</div>""";
        break;
      default: dataHtml = """<div>Hola</div>""";
    }  
  }

  Widget _contenido(){
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child:HtmlTextView(
        data: dataHtml,
      )
    );
  }

  _appBar(){
    String _t = title[0].toUpperCase()+title.substring(1);
    return AppBar(
      title:Container(
        width: MediaQuery.of(context).size.width/0.7,
          child: AutoSizeText(
            _t,
            style: appbarTitle,
            maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 5.0 ,
          )
        ),
      centerTitle: true,
    );
  }
}