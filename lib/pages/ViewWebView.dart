import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewWebView extends StatefulWidget {
  String url;
  String title;
  ViewWebView({
    @required this.url,
    @required this.title
  });
  @override
  _ViewWebViewState createState() => _ViewWebViewState();
}

class _ViewWebViewState extends State<ViewWebView> {
  ScrollController _scrollController = new ScrollController();
  Completer<WebViewController> _controller = Completer<WebViewController>();
  double width;
  String url;
  String title;

  @override
  void initState() {
    // TODO: implement initState
    url = this.widget.url;
    title = this.widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      //extendBodyBehindAppBar: true,
      //backgroundColor: Colors.white,
      appBar: _appBar(),
      body:   _webView(), 
    ); 
  }

  Widget _webView(){
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },          
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith(url)) {
          //print('blocking navigation to $request}');
          return NavigationDecision.prevent;
        }
        //print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        //print('Page finished loading: $url');
      },
      gestureNavigationEnabled: true,
    );
  }
  _appBar(){
    String _t = title[0].toUpperCase()+title.substring(1);
    return AppBar(
      title: Text(_t,style: appbarTitle),
      centerTitle: true,
    );
  }
}