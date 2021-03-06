import 'package:flutter/material.dart';

import 'package:age/age.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/docIdentificacion.dart';
import 'package:precheckin/utils/tools_util.dart' as tools;

class CardAcompanante extends StatefulWidget {
  Color primaryColor;
  Widget signature;
  Acompaniantes acompaniante;
  TextEditingController controllerText;
  bool adultos;
  bool menores;
  bool nuevo;
  int posi;
  Widget btnEncuesta;

  CardAcompanante({
    @required this.signature,
    @required this.posi,
    this.primaryColor,
    @required this.acompaniante,
    this.adultos = true,
    this.menores = true,
    this.nuevo = false,
    this.btnEncuesta
  });

  @override
  _CardAcompananteState createState() => _CardAcompananteState();
}

class _CardAcompananteState extends State<CardAcompanante> {
  double width;
  Widget _signature;
  int posi;
  Acompaniantes _acompaniante;
  DateTime _date = DateTime.now();
  DateTime _fecaNac = DateTime.now();
  TextEditingController _controllerText = new TextEditingController();
  TextEditingController _controllerFechaEdad = new TextEditingController();
  Widget _btnEncuesta;

  @override
  void initState() {
    super.initState();
    posi =  this.widget.posi;
    _signature    = this.widget.signature;
    _acompaniante = this.widget.acompaniante;
    _btnEncuesta  = this.widget.btnEncuesta;
    _fecaNac      = DateTime.parse(_acompaniante.fechanac.replaceAll('-', ""));
    _date         = _fecaNac;
    _controllerText.text = _acompaniante?.nombre;
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    _controllerFechaEdad.text = "${_fecaNac.day.toString()}/${_fecaNac.month.toString()}/${_fecaNac.year.toString()}";

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left:20.0, right:20.0, top:15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _nombre(),
              Container(
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[_fechaNacimiento(), _edad()],
                )
              ),
            ],
          )
        ),

        Container(
          padding: EdgeInsets.only(left:20.0, right:20.0, top:15.0),
          child: DocIdentificacion(acompaniantes:_acompaniante, posi: posi,),
        ),

        Container(
          padding: EdgeInsets.only(left:20.0, right:20.0, top:15.0),
          child: _btnEncuesta,
        ),

        Container(
          padding: EdgeInsets.only(left:20.0, right:20.0, top:15.0),
          width: width,
          child: Text(Translations.of(context).text('firma_aco'), style:TextStyle(fontSize: 15)), 
        ),

        Container(
          padding: EdgeInsets.only(left:20.0, right:20.0, top:15.0),
          child: _signature,
        ),
      ],
    );
  }

  Widget _nombre() {
    return Container(
      width: width - 30,
      child: TextFormField(
        controller: _controllerText,
        onFieldSubmitted: (val) => _acompaniante.nombre = _controllerText.text,
        onChanged: (val) => _acompaniante.nombre = _controllerText.text,
        decoration: InputDecoration(labelText: Translations.of(context).text('nombre')),
      )
    );
  }

  Widget _fechaNacimiento() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            width: ((width - 30) *0.40),
            child:  new Theme(
              data: ThemeData(
                primarySwatch: Colors.red,
                primaryColor: Color.fromRGBO(191, 52, 26, 1),//Head background
                accentColor: Color.fromRGBO(191, 52, 26, 1),
                splashColor: Color.fromRGBO(191, 52, 26, 1),
                primaryTextTheme: TextTheme(headline: TextStyle(color: Color.fromRGBO(191, 52, 26, 1))) ,
                textTheme:TextTheme(headline: TextStyle(color: Color.fromRGBO(191, 52, 26, 1))) ,
                accentTextTheme: TextTheme(headline: TextStyle(color: Color.fromRGBO(191, 52, 26, 1)))
              ),
              child: new Builder(
                builder: (context) => new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 0),
                      child: Text(
                        Translations.of(context).text('fec_nacimiento'),
                        style: greyText.copyWith(fontSize: 10,fontWeight: FontWeight.w200),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: new TextFormField(
                        style: greyText.copyWith(fontWeight: FontWeight.bold),
                        controller: _controllerFechaEdad,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                      ) 
                    )
                  ],
                ),
              )
            )
        )
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime firstDate = DateTime(1910);
    DateTime lastDate = DateTime.now();
    DateTime initialDate = _fecaNac;

    final DateTime picked = await showDatePicker(
      context: context,
      locale: Translations.of(context).locale,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate
    );
    
    if (picked != null && picked != _date) {
      int age = Age.dateDifference(
        fromDate      : picked,
        toDate        : DateTime.now(),
        includeToDate : false
      ).years;
      
      //TODO: parametrizar la edad
      if(widget.adultos && age >= 18 && widget.nuevo) {
        tools.showAlert(context, Translations.of(context).text("not_more_adults"));
        return null;
      }

      //TODO: parametrizar la edad
      if(widget.menores && age < 18 && widget.nuevo) {
        tools.showAlert(context, Translations.of(context).text("not_more_minors"));
        return null;
      }
      
      setState(() {
        _fecaNac                  = picked;
        _acompaniante.edad        = age.toString();
        _acompaniante.fechanac    = picked.toString();
        _controllerFechaEdad.text = "${_fecaNac.day.toString()}/${_fecaNac.month.toString()}/${_fecaNac.year.toString()}";
      });
    }
  }

  Widget _edad() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              Translations.of(context).text('edad'),
              style: greyText.copyWith(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                '${_acompaniante?.edad ?? 0} ' +
                    Translations.of(context).text('anios'),
                style: greyText.copyWith(fontSize: 15))
          ],
        )
      )
    );
  }
}
