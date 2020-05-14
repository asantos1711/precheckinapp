import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/docIdentificacion.dart';

class CardAcompanante extends StatefulWidget {
  Color primaryColor;
  Widget signature;
  Acompaniantes acompaniante;
  TextEditingController controllerText;
  CardAcompanante({
    @required this.signature,
    this.primaryColor,
    @required this.acompaniante,
    //@required this.controllerText
  });

  @override
  _CardAcompananteState createState() => _CardAcompananteState();
}

class _CardAcompananteState extends State<CardAcompanante> {
  double width;
  Widget _signature;
  Acompaniantes _acompaniante;
  DateTime _date = DateTime.now();
  DateTime _fecaNac = DateTime.now();
  TextEditingController _controllerText = new TextEditingController();
  TextEditingController _controllerFechaEdad = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _signature = this.widget.signature;
    _acompaniante = this.widget.acompaniante;
    _fecaNac = DateTime.parse(_acompaniante.fechanac.replaceAll('-', ""));
    _date = _fecaNac;
    _controllerText.text = _acompaniante?.nombre;
    print("FECHA NACIMIENTO ===" + _fecaNac.toString());
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _fecaNac,
        locale: Translations.of(context).locale,
        firstDate: DateTime(1910),
        lastDate: DateTime.now());
    if (picked != null && picked != _date)
      setState(() {
        _fecaNac = picked;
        _acompaniante.fechanac = _fecaNac.toString();
        _acompaniante.edad = Age.dateDifference(
                fromDate: _fecaNac,
                toDate: DateTime.now(),
                includeToDate: false)
            .years
            .toString();
        print("EDAD===" + _acompaniante.edad);
        _controllerFechaEdad.text =
            "${_fecaNac.day.toString()}/${_fecaNac.month.toString()}/${_fecaNac.year.toString()}";
      });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    _controllerFechaEdad.text =
        "${_fecaNac.day.toString()}/${_fecaNac.month.toString()}/${_fecaNac.year.toString()}";
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
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[_fechaNacimiento(), _edad()],
                )),
              ],
            )),
        _signature,
        DocIdentificacion(acompaniantes:_acompaniante),
      ],
    ));
  }

  Widget _nombre() {
    return Container(
        width: width - 30,
        child: TextFormField(
          controller: _controllerText,
          onFieldSubmitted: (val) {
            //_controllerText.text =  val;
            _acompaniante.nombre = _controllerText.text;
          },
          onChanged: (val) {
            _acompaniante.nombre = _controllerText.text;
          },
          decoration: InputDecoration(
              labelText: Translations.of(context).text('nombre')),
        ));
  }

  Widget _fechaNacimiento() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            width: (width - 30) / 2,
            child:  new Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Theme.of(context).primaryColor,
                accentColor: Theme.of(context).primaryColor,
                splashColor: Theme.of(context).primaryColor,
              ),
              child: new Builder(
                builder: (context) =>new TextFormField(
                  controller: _controllerFechaEdad,
                  decoration: InputDecoration(
                      labelText: Translations.of(context).text('fec_nacimiento')),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ) ,
              )
            )/* TextFormField(
              controller: _controllerFechaEdad,
              decoration: InputDecoration(
                  labelText: Translations.of(context).text('fec_nacimiento')),
              readOnly: true,
              onTap: () => _selectDate(context),
            ) */
        )
    );
  }

  Widget _edad() {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            alignment: Alignment.centerRight,
            //width: (width-30)/2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  Translations.of(context).text('edad'),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    '${_acompaniante?.edad ?? 0} ' +
                        Translations.of(context).text('anios'),
                    style: TextStyle(fontSize: 15))
              ],
            )));
  }
}
