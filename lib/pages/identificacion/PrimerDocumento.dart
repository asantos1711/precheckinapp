import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:precheckin/models/ScanerModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mrzflutterplugin/mrzflutterplugin.dart';
class PrimerDocumento extends StatefulWidget {
  @override
  _PrimerDocumentoState createState() => _PrimerDocumentoState();
}

class _PrimerDocumentoState extends State<PrimerDocumento> {
  String _result = 'No result yet';
  ScanerModel _scanerModel = new ScanerModel();
  String fullImage;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      Mrzflutterplugin.registerWithLicenceKey("android_licence_key");
    } else if (Platform.isIOS) {
      Mrzflutterplugin.registerWithLicenceKey("C500C89F1E88DC48B05981B3CB55CEB287CB42CEC4886223D30555F0DE9B7C036E6C0BB2563CB6B933376B3590FA5FA52B5AAC55F8FA6F90777EAC1474E360655681C3AA91770BEBC3E2C524BBFB05E8");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (fullImage != null)? Image.memory(base64Decode(fullImage)):Container(),
              new FlatButton(
                child: Text("Start Scanner"),
                onPressed: startScanning,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Result: $_result  ${_scanerModel.surname}'),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> startScanning() async {
    String scannerResult;
    ScanerModel res;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      Mrzflutterplugin.setIDActive(true);
      Mrzflutterplugin.setPassportActive(true);
      Mrzflutterplugin.setVisaActive(true);

      String jsonResultString = await Mrzflutterplugin.startScanner;

      Map<String, dynamic> jsonResult = jsonDecode(jsonResultString);
       dynamic a = jsonDecode(jsonResultString);
       res = ScanerModel.fromJson(jsonResult);
      print(jsonResult);

      
      fullImage = jsonResult['full_image'];
        
      scannerResult = jsonResult.toString();
      
      print(scannerResult);
    } on PlatformException catch (ex) {
      String message = ex.message;
      scannerResult = 'Scanning failed: $message';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanerModel = res;
      _result = scannerResult;
    });
  }
}