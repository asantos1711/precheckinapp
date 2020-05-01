import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class CardAcompanante extends StatefulWidget {
Color primaryColor ;
Widget signature;
DateTime date;
TextEditingController controllerText;
CardAcompanante(
  {
    this.date,
    this.signature,
    this.primaryColor,
    this.controllerText
  }
);

  @override
  _CardAcompananteState createState() => _CardAcompananteState();
}

class _CardAcompananteState extends State<CardAcompanante> {
  double width ;
  Widget _signature;
  DateTime _date = DateTime.now();
  TextEditingController _controllerText;
  @override
  void initState() {
    // TODO: implement initState
    _signature = this.widget.signature;
    _controllerText = this.widget.controllerText;
    _date = this.widget.date;
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _date)
      setState(() {
        _date = picked;
        _controllerText.text = _date.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: width,
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: width-30,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nombre"
                    ),
                  )
                ),
                Container(
                  width: width-20,
                  child: Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: (width-30)/2,
                          child: TextFormField(
                            controller: _controllerText,
                            decoration: InputDecoration(
                              labelText: "Fecha de Salida"
                            ),
                            readOnly: true,
                            onTap:()=> _selectDate(context),
                          )
                        )
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: (width-30)/2,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Edad', style: TextStyle(fontWeight: FontWeight.w600),),
                              SizedBox(height: 5,),
                              Text('20 años')
                            ],
                          )
                        )
                      )
                    ],
                  )
                ),
              ],
            )
          ),
          _signature,
          Container(
            color: Colors.white,
            width: width-20,
            child:Row(
              children: <Widget>[
                Container(
                  width: ((width-20)/3)*2,
                  child: Text('Documento de identificación',style: TextStyle(color: Colors.blueAccent,fontSize: 18),)
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: (width-20)/3,
                  child: Icon(Icons.camera_alt, color: Colors.deepOrange,size: 30,)
                )
              ],
            )
          )
        ],
      )
    );
  }

  
}