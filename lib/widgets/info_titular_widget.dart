import 'package:flutter/material.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';

import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/utils/fecha_util.dart';
import 'package:precheckin/utils/tools_util.dart';
import 'package:precheckin/utils/validaciones_util.dart';
import 'package:precheckin/widgets/estados_widget.dart';
import 'package:precheckin/widgets/paises_widget.dart';

class InfoTitular extends StatefulWidget {
  PMSBloc pmsBloc;

  InfoTitular({
    @required this.pmsBloc
  });

  @override
  _InfoTitularState createState() => _InfoTitularState();
}

class _InfoTitularState extends State<InfoTitular> {
  PMSBloc _pmsBloc;
  double _screenWidth;
  DateTime _fechaNacimiento;
  TextEditingController _ctrlNombre;
  TextEditingController _ctrlFecha;
  TextEditingController _ctrlEdad;
  TextEditingController _ctrlCiudad;
  TextEditingController _ctrlCP;
  String _pais;
  String _estado;

  @override
  void initState() {
    super.initState();

    _pmsBloc         = this.widget.pmsBloc;
    _fechaNacimiento = _pmsBloc?.fnTituar;
    _pais            = _pmsBloc?.pais;
    _estado          = _pmsBloc?.estado;
    _ctrlNombre      = new TextEditingController(text: _pmsBloc?.nombreTitular);
    _ctrlFecha       = new TextEditingController(text: (_fechaNacimiento == null) ? "" : "${_fechaNacimiento.day}/${_fechaNacimiento.month}/${_fechaNacimiento.year}");
    _ctrlEdad        = new TextEditingController(text: _pmsBloc.edadTitular.toString());
    _ctrlCiudad      = new TextEditingController(text: _pmsBloc.ciudad);
    _ctrlCP          = new TextEditingController(text: _pmsBloc.codigoPostal);
  }


  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(Translations.of(context).text('info_titular'), style:titulos.copyWith(fontSize: 20)),
          SizedBox(height: 5.0,),
          _nombre(),
          SizedBox(height: 5.0,),
          _fechaAndEdad(),
          SizedBox(height: 5.0,),
          _paisAndEstado(),
          SizedBox(height: 5,),
          _ciudadAndCodigoPostal(),
        ],
      );
  }



  Widget _nombre(){
    return TextFormField(
      controller: _ctrlNombre,
      style: greyText.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
      decoration: InputDecoration(
        labelText: Translations.of(context).text('nombre'),
        labelStyle: greyText.copyWith(fontWeight: FontWeight.w200),
      ),
      onChanged: (nombre) => _pmsBloc.nombreTitular = nombre,
      validator: (nombre) => isRequired(context, nombre),
    );
  }

  Widget _fechaAndEdad(){
    return Row(
      children: <Widget>[
        Container(
          width: (_screenWidth - 40) * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(Translations.of(context).text('fec_nacimiento'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
              TextFormField(
                controller: _ctrlFecha,
                style: greyText.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (fecha) => isAdult(context, true, val: fecha, splitBy: '/')
              )
            ],
          ),
        ),
        Expanded(child: Container(),),
        Container(
          width: (_screenWidth - 40) * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(Translations.of(context).text('edad'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
              Text(_ctrlEdad.text)
            ],
          ),
        ),
      ],
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime ahora     = new DateTime.now();
    DateTime firstDate = new DateTime((ahora.year - 120), ahora.month, ahora.day);
    DateTime lastDate  = ahora;

    final DateTime picked = await showDatePicker(
      context: context,
      locale: Translations.of(context).locale,
      initialDate: _fechaNacimiento ?? ahora,
      firstDate: firstDate,
      lastDate: lastDate
    );

    if (picked != null) {
      setState(() {
        int age = getEdad(picked);
        if(age < 18)
          showAlert(context, Translations.of(context).text("adult_required"));
        else {
          _ctrlEdad.text     = age.toString();
          _ctrlFecha.text    = "${picked.day}/${picked.month}/${picked.year}";
          _pmsBloc.fnTitular = "${picked.year}-${picked.month}-${picked.day}";
        }
      });
    }
  }

  Widget _paisAndEstado(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _dropdownPaises(),
          _dropdownEstado(),
          ],
      )
    );
  }

  Widget _dropdownPaises(){
    return Container(
      width: (_screenWidth - 50) / 2,
      padding: EdgeInsets.only(top: 5, right: 10),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translations.of(context).text('pais'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          PaisesWidget(
            hotel:_pmsBloc.idHotel,
            valorInicial: _pais ?? "MEX",
            change: (pais) => setState(() {
              _pais         = pais;
              _pmsBloc.pais = pais;
            })
          )
        ]
      ),
    );
  }

  Widget _dropdownEstado(){
    return Container(
      width: (_screenWidth - 50) / 2,
      padding: EdgeInsets.only(top: 5, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translations.of(context).text('estado'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          EstadosWidget(
            hotel: _pmsBloc.idHotel,
            pais:  _pais,
            valorInicial: _estado,
            change: (estado) => setState((){
              _estado = estado;
              _pmsBloc.estado = estado;
            }),
          )
        ],
      ),
    );
  }

  Widget _ciudadAndCodigoPostal(){

    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10),
          width: (_screenWidth - 50) / 2,
          child: TextFormField(
            controller: _ctrlCiudad,
            style: greyText.copyWith(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelText: Translations.of(context).text('ciudad'),
              labelStyle: greyText.copyWith(fontWeight: FontWeight.w200),
            ),
            onChanged: (ciudad) => _pmsBloc.ciudad = ciudad,
          )
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          width: (_screenWidth - 50) / 2,
          child: TextFormField(
            controller: _ctrlCP,
            style: greyText.copyWith(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelText: Translations.of(context).text('cod_postal'),
              labelStyle: greyText.copyWith(fontWeight: FontWeight.w200),
            ),
            onChanged: (cp) => _pmsBloc.codigoPostal = cp,
          )
        )
      ],
    );
  }
}