import 'package:flutter/material.dart';

import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/aerolinea_widget.dart';

class InfoVuelo extends StatefulWidget {
  PMSBloc pmsBloc;

  InfoVuelo({
    @required this.pmsBloc
  });

  @override
  _InfoVueloState createState() => _InfoVueloState();
}

class _InfoVueloState extends State<InfoVuelo> {
  PMSBloc _pmsBloc;
  double _screenWidth;
  DateTime _fechaVuelo;
  TextEditingController _ctrlAerolinea;
  TextEditingController _ctrlFecha;
  TextEditingController _ctrlNumeroVuelo;

  @override
  void initState() {
    super.initState();

    _pmsBloc         = this.widget.pmsBloc;
    _fechaVuelo      = _pmsBloc.fechaVuelo;
    _ctrlAerolinea   = TextEditingController(text: _pmsBloc.aerolinea);
    _ctrlFecha       = TextEditingController(text: "${_fechaVuelo.day}/${_fechaVuelo.month}/${_fechaVuelo.year}");
    _ctrlNumeroVuelo = TextEditingController(text: _pmsBloc.numeroVuelo);
  }


  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: _screenWidth,
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(bottom: 10, left:10),
              width: _screenWidth-20,
              child: Text(
                Translations.of(context).text('agre_info_vuelo'),
                style: blueAcentText.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
              decoration: boxDecorationDefault,
            ),
          SizedBox(height: 5,),
          Container(
            child: AerolineasWidget(
              valorInicial: _ctrlAerolinea.text,
              onTap: (value) {
                _ctrlAerolinea.text = value;
                _pmsBloc.aerolinea  = value;
              },
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: (_screenWidth - 60 )/2,
                child: TextFormField(
                  controller: _ctrlFecha,
                  decoration: InputDecoration(
                    labelText: Translations.of(context).text('fec_salida'),
                    labelStyle:  greyText.copyWith(fontWeight: FontWeight.w200),
                  ),
                  style: greyText.copyWith(fontWeight: FontWeight.bold),
                  readOnly: true,
                  onTap: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDate(context);
                  }
                )
              ),
              Expanded(child: Container(),),
              Container(
                width: (_screenWidth - 60 )/2,
                child: TextFormField(
                  controller: _ctrlNumeroVuelo,
                  style: greyText.copyWith(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      labelText: Translations.of(context).text('no_vuelo'),
                      labelStyle: greyText.copyWith(fontWeight: FontWeight.w200)
                  ),
                  onChanged: (numero) => _pmsBloc.numeroVuelo = numero,
                )
              )
            ],
          ),
        ],
      )
    );
  }


  Future<Null> _selectDate(BuildContext context) async {
    DateTime firstDate = new DateTime.now();
    DateTime lastDate = new DateTime((firstDate.year + 50), firstDate.month, firstDate.day);

    final DateTime picked = await showDatePicker(
      context: context,
      locale: Translations.of(context).locale,
      initialDate: _fechaVuelo,
      firstDate: (_fechaVuelo.isBefore(firstDate)) ? _fechaVuelo : firstDate,
      lastDate: lastDate
    );
     
    if (picked != null) {
      setState(() {
        _fechaVuelo = picked;
        _pmsBloc.fechaVuelo = picked;
        _ctrlFecha.text ="${_fechaVuelo.day}/${_fechaVuelo.month}/${_fechaVuelo.year}";
      });
    }
  }
}