import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:precheckin/models/commons/politicas_model.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/utils/tools_util.dart';
import 'package:precheckin/widgets/btn_encuesta_salud_widget.dart';
import 'package:precheckin/widgets/check_text_bold.dart';
import 'package:precheckin/widgets/docIdentificacion.dart';
import 'package:precheckin/widgets/info_hospedaje.dart';
import 'package:precheckin/widgets/info_titular_widget.dart';
import 'package:precheckin/widgets/info_contacto.dart';
import 'package:precheckin/widgets/info_vuelo_widget.dart';
import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/widgets/signature_widget.dart';
import 'package:signature/signature.dart';

class HabitacionTitular extends StatefulWidget {
  @override
  _HabitacionTitularState createState() => _HabitacionTitularState();
}

class _HabitacionTitularState extends State<HabitacionTitular> with TickerProviderStateMixin{
  PMSBloc _pmsBloc;
  final _formKey = GlobalKey<FormState>();
  double _screenWidth;
  List<Politicas> _politicas;
  SignatureController _ctrlFirma = SignatureController();
  
  AnimationController _controller;
  static const List<String> _funcionList = const [ "1","2" ];
  Map<String,String> _opcionesFloat = new  Map<String,String>();

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _pmsBloc    = new PMSBloc();
    _pmsBloc.initCheckbox = 1;
    _politicas = _pmsBloc.politicas;
    _pmsBloc.posRoute = 1;
    _ctrlFirma.addListener((){});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _opcionesFloat["1"] = Translations.of(context).text('opcion_duda').toString();
    _opcionesFloat["2"] = Translations.of(context).text('opcion_error').toString();
    _screenWidth = (MediaQuery.of(context).size.width) - 40;
    setState(()=>_pmsBloc.posRoute = 1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: ListView(
        children: <Widget>[
          _seccionReservacion(),
          _infoTitular(),
          _documentos(),
          _seccionVuelo(),
          _buttonEncuentaCovid(),
          _terminosCondiciones(),
          _firma(),
          _buttonContinuar(),
        ],
      ),
      //floatingActionButton: _floatButton(),
    );
  }

  Widget _appBar(){
    return AppBar(
      leading: Container(),
      title:Container(
        width: MediaQuery.of(context).size.width/0.7,
          child: AutoSizeText(
            Translations.of(context).text('info_reservacion'),
            style: appbarTitle,
            maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 5.0 ,
          )
        ),
      centerTitle: true,
    );
  }

   Widget _seccionReservacion(){
    return Container(
      decoration: BoxDecoration(color: backgroundBloqueado),
      padding: EdgeInsets.all(20.0),
      child: InfoHospedaje(
        reserva: _pmsBloc.reserva,
        result: _pmsBloc.result
      )
    );
  }

  Widget _infoTitular(){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _seccionTitular(),
          _seccionContacto(),
        ],
      ),
    );
  }

  Widget _seccionTitular(){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: InfoTitular(
        pmsBloc: _pmsBloc
      )
    );
  }
  
  Widget _seccionContacto(){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: InfoContacto(
        block: _pmsBloc,
      )
    );
  }

  Widget _documentos(){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: DocIdentificacion(acompaniantes: _pmsBloc.titular)
    );
  }
  
  Widget _seccionVuelo(){
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: InfoVuelo(
        pmsBloc: _pmsBloc,
      ),
    );
  }

  Widget  _buttonEncuentaCovid() => Center(
    child: BtnEncuestaSalud(
      pmsBloc: _pmsBloc,
      posicion: -1,
    ),
  );


  Widget _terminosCondiciones(){
    return Container(
      padding:EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _reglamentoHotel(),
          _politicasProcedimientos(),
          _avisoProvacidad(),
          _reglamentoCovid(),
          _recibirInformacion(),
        ],
      ),
    );
  }

  Widget _reglamentoHotel(){
    return CheckTextBold( context,
      width: _screenWidth,
      value: (_pmsBloc.reglamento==1) ? true : false,
      onChange: (val)=> setState(()=> _pmsBloc.reglamento=val ? 1 : 0),
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('reglamento_hotel'),
      viewWebVal: 'reglamento_hotel',
      politicas: _politicas,
    );
  }

  Widget _politicasProcedimientos(){
    return CheckTextBold( context,
      width: _screenWidth,
      value: (_pmsBloc.politicasProcesos==1) ? true : false,
      onChange: (val)=> setState(()=> _pmsBloc.politicasProcesos=val ? 1 : 0),
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('politicas_procedimientos'),
      viewWebVal: 'politicas_procedimientos',
      politicas: _politicas,
    );
  }

  Widget _avisoProvacidad(){
    return CheckTextBold( context,
      width: _screenWidth,
      value: (_pmsBloc.avisoPrivacidad==1) ? true : false,
      onChange: (val)=> setState(()=> _pmsBloc.avisoPrivacidad=val ? 1 : 0),
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('aviso_privacidad'),
      viewWebVal: 'aviso_privacidad',
      politicas: _politicas,
    );
  }

  Widget _reglamentoCovid(){
    return CheckTextBold( context,
      width: _screenWidth,
      value: (_pmsBloc.reglasCovid==1) ? true : false,
      onChange: (val)=> setState(()=> _pmsBloc.reglasCovid=val ? 1 : 0),
      text: Translations.of(context).text('reglameto_covid'),
      textBold: '',
      viewWebVal: '',
      politicas: _politicas,
    );
  }

  Widget _recibirInformacion(){
    return CheckTextBold( context,
      width: _screenWidth,
      value: (_pmsBloc.promocion==1) ? true : false,
      onChange: (val)=> setState(()=> _pmsBloc.promocion=val ? 1 : 0),
      text: Translations.of(context).text('recibir_info'),
      textBold: '',
      viewWebVal: '',
      politicas: _politicas,
    );
  }


  Widget _firma() {
    _ctrlFirma.addListener(() async {
      var data = await _ctrlFirma.toPngBytes();
      if(data != null){
          _pmsBloc.signTitular = base64.encode(data);
      }
    });

    return Container(
      padding: EdgeInsets.all(20.0),
      child: SignatureWidget(
        img: _pmsBloc.signTitular ?? "",
        title:Translations.of(context).text('ingresa_firma_titular'),
        controller: _ctrlFirma,
      ),
    );
  }

  Widget  _buttonContinuar(){
    return Container(
      width: double.infinity - 20,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      color: Colors.white,
      child:FlatButton(
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.orange,
        onPressed: (_pmsBloc.bloquearBoton()) ? null : () {
          if(_pmsBloc.fnTituar == null || _pmsBloc.nombreTitular == null)
            showAlert(context, Translations.of(context).text("name_age_invalid"));
          else if(_pmsBloc.verificarEncuenta(-1))
            Navigator.pushNamed(context, 'infoAdicional');
          else
            showAlert(context, Translations.of(context).text("cuestionary_required"));
        },
        child: Text(
          Translations.of(context).text('continuar'),
          style: TextStyle(fontSize: 20.0, fontFamily: "Montserrat"),
        ),
      )
    );
  }

  Widget _floatButton(){
    return new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(_funcionList.length, (int index) {
          Widget child = Align(
            alignment: Alignment.centerRight,
            child: new Container(
              height: 80.0,
              width: 300.0,
              alignment: FractionalOffset.topCenter,
              child: new ScaleTransition(
                scale: new CurvedAnimation(
                  parent: _controller,
                  curve: new Interval(
                    0.0,
                    1.0 - index / _funcionList.length / 2.0,
                    curve: Curves.easeOut
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Text(_opcionesFloat[(index+1).toString()], style: TextStyle(fontSize: 18, color:  Color(0xFFE87200)),)
                  ),
                ),
          ),
            ),
          );
          return child;
        }).toList()..add(
          Align(
            alignment: Alignment.centerRight,
            child: new FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Icon(FontAwesomeIcons.exclamationCircle , color: Colors.red,size: 28, );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            )
          ),
        ),
      );
  }
}