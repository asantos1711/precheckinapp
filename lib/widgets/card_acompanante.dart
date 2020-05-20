import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/docIdentificacion.dart';

class CardAcompanante extends StatefulWidget {
  Color primaryColor;
  Widget signature;
  Acompaniantes acompaniante;
  TextEditingController controllerText;
  bool adultos;
  bool menores;
  bool nuevo;
  CardAcompanante({
    @required this.signature,
    this.primaryColor,
    @required this.acompaniante,
    this.adultos = true,
    this.menores = true,
    this.nuevo = false
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
    print("PREFECHA NACIMIENTO ===" +_acompaniante.fechanac);
    _fecaNac = DateTime.parse(_acompaniante.fechanac.replaceAll('-', ""));
    _date = _fecaNac;
    
    //git add -_fecaNac.;
    _controllerText.text = _acompaniante?.nombre;
    print("FECHA NACIMIENTO ===" + _fecaNac.toString());
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime ahora = DateTime.now();
    DateTime firstDate = DateTime(1910);
    DateTime lastDate = DateTime.now();
    DateTime initialDate = _fecaNac;

    if(!widget.adultos) 
        firstDate = DateTime(lastDate.year - 17);

    
    if(!widget.menores && widget.nuevo){
      initialDate = DateTime(ahora.year - 18, ahora.month, ahora.day);
      lastDate = DateTime(ahora.year - 18, ahora.month, ahora.day);
    }

    final DateTime picked = await showDatePicker(
      context: context,
      locale: Translations.of(context).locale,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate
    );
    
    if (picked != null && picked != _date)
      setState(() {
        _fecaNac = picked;
        _acompaniante.fechanac = picked.toString();
        _acompaniante.edad = Age.dateDifference(
                fromDate: _fecaNac,
                toDate: DateTime.now(),
                includeToDate: false)
            .years
            .toString();
        print("EDAD===" + _acompaniante.edad);
        print("Fecha===" + "${_acompaniante.fechanac}");
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
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          width: width,
          child: Text(Translations.of(context).text('firma_aco'), style:TextStyle(fontSize: 15)), 
        ),
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
                        //decoration: InputDecoration(
                          //hintMaxLines: 4,
                          //labelStyle: TextStyle(fontSize: 14),
                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                          //labelText: Translations.of(context).text('fec_nacimiento')
                        //),
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
            )));
  }
}
