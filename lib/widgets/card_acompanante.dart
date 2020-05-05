import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:signature/signature.dart';

/*
Concidera cambiar este widget por un StateLess para que se encarge solo de pintar el
los componentes y la funcionalidad la puedes manejar pasando funciones por rererencia,

Falta el parámetro para poner el nombre.
El widget para seleccionar aparece en ingles cuando selecciono español.
*/





class CardAcompanante extends StatefulWidget {
Color primaryColor ;
Widget signature;
Acompaniantes acompaniante;
TextEditingController controllerText;
CardAcompanante(
  {
    @required this.signature,
    this.primaryColor,
    @required this.acompaniante,
    //@required this.controllerText
  }
);

  @override
  _CardAcompananteState createState() => _CardAcompananteState();
}

class _CardAcompananteState extends State<CardAcompanante> {
  double width ;
  Widget _signature;
  Acompaniantes _acompaniante;
  DateTime _date = DateTime.now();
  TextEditingController _controllerText= new TextEditingController();
  TextEditingController _controllerFechaEdad = new TextEditingController();
  DateTime _fecaNac = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    _signature = this.widget.signature;
    _acompaniante =  this.widget.acompaniante;
    _fecaNac =  DateTime.parse(_acompaniante.fechanac.replaceAll('-', ""));
    _date =  _fecaNac;
    _controllerText.text = _acompaniante?.nombre;
    print("FECHA NACIMIENTO ===" +_fecaNac.toString());
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _fecaNac,
        firstDate: DateTime(1910),
        lastDate: DateTime(2101));
    if (picked != null && picked != _date)
      setState(() {
        _fecaNac = picked;
        _acompaniante.fechanac =_fecaNac.toString();
        _acompaniante.edad =Age.dateDifference(fromDate: _fecaNac, toDate: DateTime.now(), includeToDate: false).years.toString(); 
        print("EDAD==="+_acompaniante.edad);
        _controllerFechaEdad.text = "${_fecaNac.day.toString()}/${_fecaNac.month.toString()}/${_fecaNac.year.toString()}";
      });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    _controllerFechaEdad.text = "${_fecaNac.day.toString()}/${_fecaNac.month.toString()}/${_fecaNac.year.toString()}";
    //_controllerFechaEdad = new TextEditingController(text: _fecaNac.toString());
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
                _nombre(),
                Container(
                  width: width-20,
                  child: Row(
                    children: <Widget>[
                      _fechaNacimiento(),
                      _edad()
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
          ),
        ],
      )
    );
  }

  Widget _nombre(){
    return Container(
      width: width-30,
      child: TextFormField(
        controller: _controllerText,
        decoration: InputDecoration(
          labelText: 'Nombre'
        ),
      )
    );
  }
  Widget _fechaNacimiento(){
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: (width-30)/2,
          child: TextFormField(
            controller: _controllerFechaEdad,
            decoration: InputDecoration(
              labelText: "Fecha de nacimiento"
            ),
            readOnly: true,
            onTap:()=> _selectDate(context),
          )
        )
      );
  }
  
  Widget _edad(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        alignment: Alignment.centerRight,
        width: (width-30)/2,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Edad ', style: TextStyle(fontWeight: FontWeight.w600),),
            SizedBox(height: 5,),
            Text('${_acompaniante?.edad??0} años')
          ],
        )
      )
    );
  }
  
}