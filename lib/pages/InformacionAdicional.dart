import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class InformacionAdicional extends StatefulWidget {
  @override
  _InformacionAdicionalState createState() => _InformacionAdicionalState();
}

class _InformacionAdicionalState extends State<InformacionAdicional> {

  final SignatureController _controller = SignatureController(penStrokeWidth: 5, penColor: Colors.red);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }

      },
      child:Scaffold(
        appBar: _appBar(),
        body: ListView(
            children: <Widget>[
              //SIGNATURE CANVAS
              Signature(controller: _controller, height: 300, backgroundColor: Colors.white),
              //OK AND CLEAR BUTTONS
              Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //SHOW EXPORTED IMAGE IN NEW ROUTE
                    IconButton(
                      icon: const Icon(Icons.check),
                      color: Colors.blue,
                      onPressed: () async {
                        if (_controller.isNotEmpty) {
                          var data = await _controller.toPngBytes();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Scaffold(
                                  appBar: AppBar(),
                                  body: Center(child: Container(color: Colors.grey[300], child: Image.memory(data))),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                    //CLEAR CANVAS
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.blue,
                      onPressed: () {
                        setState(() => _controller.clear());
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 300,
                child: Center(
                  child: Text('Big container to test scrolling issues'),
                ),
              ),
            ],
          ),
      )
    );
  }


  Widget _appBar(){
    return AppBar(
      backgroundColor: Colors.deepOrange,
      leading: Container(),
      title:Text('Información de reservación') ,
    );
  }
}