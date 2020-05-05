import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mrzflutterplugin/mrzflutterplugin.dart';
class PrimerDocumento extends StatefulWidget {
  @override
  _PrimerDocumentoState createState() => _PrimerDocumentoState();
}

class _PrimerDocumentoState extends State<PrimerDocumento> {
  String _result = 'No result yet';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlatButton(
                child: Text("Start Scanner"),
                onPressed: startScanning,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Result: $_result'),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> startScanning() async {
    String scannerResult;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      if (Platform.isAndroid) {
        Mrzflutterplugin.registerWithLicenceKey("android_licence_key");
      } else if (Platform.isIOS) {
        Mrzflutterplugin.registerWithLicenceKey("ios_licence_key");
      }

      Mrzflutterplugin.setIDActive(true);
      Mrzflutterplugin.setPassportActive(true);
      Mrzflutterplugin.setVisaActive(true);
      Mrzflutterplugin.scanFromGallery;

      scannerResult = await Mrzflutterplugin.startScanner;
    } on PlatformException catch (ex) {
      String message = ex.message;
      scannerResult = 'Scanning failed: $message';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _result = scannerResult;
    });
  }
}