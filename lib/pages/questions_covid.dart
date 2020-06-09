import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/models/covid_questions_model.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/utils/fecha_util.dart';
import 'package:precheckin/widgets/paises_widget.dart';

class QuestionsCovidPage extends StatefulWidget {
  @override
  _QuestionsCovidPageState createState() => _QuestionsCovidPageState();
}

class _QuestionsCovidPageState extends State<QuestionsCovidPage> {
  PMSBloc _pmsBloc;
  Acompaniantes _acompaniante;
  CovidQuestionsModel _questions;

  DateTime _ahora;
  DateTime _nacimiento;
  String _fechaAhora;
  int _edad;
  String _pais;
  String _email;
  String _tel;
  List<String> _fContacto;
  double _screenWidth;
  bool _enContacto;
  bool _temp;
  bool _ts;
  bool _mal;
  bool _dificultad;
  bool _otrosSintomas;
  TextEditingController _ctrlName;
  TextEditingController _ctrlEdad;
  TextEditingController _ctrlEmail;
  TextEditingController _ctrlCode;
  TextEditingController _ctrlTel;
  TextEditingController _ctrlPaisVisitado;
  TextEditingController _ctrlCiudadVisitado;
  TextEditingController _ctrlFechaContacto;
  TextEditingController _ctrlSintomas;

  @override
  void initState() {
    super.initState();
    _pmsBloc = new PMSBloc();
    _ahora   = new DateTime.now();

    _pais         = _pmsBloc?.pais;
    _acompaniante = _pmsBloc.getAcompaniante();
    _questions    = _acompaniante?.covidQuestions ?? new CovidQuestionsModel();
    _nacimiento   = fechaByString(_acompaniante?.fechanac);
    _edad         = getEdad(_nacimiento);
    _email        = _questions?.email ?? '';
    _tel          = _acompaniante.istitular ? _pmsBloc.telefonoTitular : (_questions?.telefono ?? '');
    _fContacto    = splitFecha(_questions?.fechaContacto).split("-");

    _fechaAhora   = "${_ahora.day}/${_ahora.month}/${_ahora.year}";
    _ctrlName     = new TextEditingController(text: _acompaniante?.nombre);
    _ctrlEdad     = new TextEditingController(text: _edad.toString());
    _ctrlEmail    = new TextEditingController(text: _email);
    _ctrlTel      = new TextEditingController(text: _tel);

    _ctrlCode           = new TextEditingController(text: _questions?.codigoArea ?? '');
    _ctrlPaisVisitado   = new TextEditingController(text: _questions?.paisesVisitados ?? '');
    _ctrlCiudadVisitado = new TextEditingController(text: _questions?.ciudadesVisitadas ?? '');
    _enContacto         = _questions?.enContacto ?? false;
    _ctrlFechaContacto  = new TextEditingController(text: (_fContacto.isEmpty || _fContacto.length<2) ? '' : '${_fContacto[2]}-${_fContacto[1]}-${_fContacto[0]}');
    _temp               = _questions?.temperatura ?? false;


    _ts                 = _questions?.tos ?? false;
    _mal                = _questions?.malestarGeneral ?? false;
    _dificultad         = _questions?.dificultadRespirar ?? false;
    _otrosSintomas      = (_questions?.otrosSintomas!= null && _questions?.otrosSintomas.isNotEmpty) ? true : false;
    _ctrlSintomas       = new TextEditingController(text: _questions?.otrosSintomas ?? '');
    
    _questions.fecha = "${_ahora.year}-${_ahora.month}-${_ahora.day}";
    _questions.edad  = _edad;
    _questions.email = _email;
  }
  
  @override
  Widget build(BuildContext context) {
    _screenWidth  = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:15.0, vertical:15.0),
        child: ListView(
          children: <Widget>[
            _title(),
            _subTitle(),
            _fecha(),
            _name(),
            _age(),
            _dropdownPaises(),
            _emailTel(),
            _lugaresVisitados(),
            _contacto(),
            _controlSaludLabel(),
            _controlSaludInstruction(),
            _temperatura(),
            _tos(),
            _malestar(),
            _respirar(),
            _sintomas(),
            _buttonGuardar()
          ],
        ),
      )
    );
  }

  Widget _appBar(){
    return AppBar(
      backgroundColor: Color(0xff37a981),
      leading: Container(),
      title:Container(
        width: MediaQuery.of(context).size.width/0.7,
          child: AutoSizeText(
            Translations.of(context).text('covid_cuestionary'),
            style: appbarTitle,
            maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 5.0 ,
          )
        ),
      centerTitle: true,
    );
  }

  Widget _title(){
    return Text(Translations.of(context).text('covid_cuestionary_title'),
      style: titulos,
      textAlign: TextAlign.center,
    );
  }

  Widget _subTitle(){
    return Container(
      margin: EdgeInsetsDirectional.only(top:20.0, bottom: 30.0),
      child: Text(Translations.of(context).text('covid_cuestionary_subtitle'),
        style: greyText.copyWith(fontWeight: FontWeight.w200),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _fecha(){
    return RichText(
      text: TextSpan(
        text: Translations.of(context).text("date")+": ",
        style: greyText.copyWith(fontWeight: FontWeight.w200),
        children: [
          TextSpan(text: _fechaAhora, style: greyText.copyWith(fontWeight: FontWeight.bold))
        ]
      )
    );
  }

  Widget _name(){
    return TextFormField(
      controller: _ctrlName,
      enabled: false,
      decoration: InputDecoration(
        icon: Text(Translations.of(context).text("nombre")+":", style: greyText.copyWith(fontWeight: FontWeight.w200),),
      ),
    );
  }

  Widget _age(){
    return Container(
      width: (_screenWidth * 0.5),
      child:TextFormField(
        controller: _ctrlEdad,
        keyboardType: TextInputType.number,
        enabled: false,
        decoration: InputDecoration(
          icon: Text(Translations.of(context).text("edad")+":", style: greyText.copyWith(fontWeight: FontWeight.w200),),
        ),
      ),
    );
  }

  Widget _dropdownPaises(){
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translations.of(context).text('procedencia'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          PaisesWidget(
            hotel:_pmsBloc.idHotel,
            valorInicial: _pais ?? "MEX",
            change: (pais) => setState(() {
              _pais         = pais;
              _pmsBloc.pais = pais;
              _questions.procedencia = pais;
            })
          )
        ]
      ),
    );
  }
 
  Widget _emailTel(){
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Translations.of(context).text('email_tel'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          SizedBox(height: 10.0,),
          Text(Translations.of(context).text('e_mail'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          TextFormField(
            controller: _ctrlEmail,
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) => _questions.email = val,
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: _screenWidth * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Translations.of(context).text('code_area'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _ctrlCode,
                      onChanged: (code) => _questions.codigoArea = code,
                    )
                  ],
                ),
              ),
              Container(
                width: _screenWidth - (_screenWidth * 0.30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Translations.of(context).text('telefono'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
                    TextFormField(
                      controller: _ctrlTel,
                      keyboardType: TextInputType.phone,
                      onChanged: (tel){
                        _questions.telefono = tel;
                      },
                    )
                  ],
                ),
              )
            ],
          )
        ]
      ),
    );
  }

  Widget _lugaresVisitados(){
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(Translations.of(context).text('pais_visitado'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          SizedBox(height: 10.0,),
          Text(Translations.of(context).text('paises'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          TextFormField(
            controller: _ctrlPaisVisitado,
            onChanged: (val) => _questions.paisesVisitados = val,
          ),
          Text(Translations.of(context).text('ciudades'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
          TextFormField(
            controller: _ctrlCiudadVisitado,
            onChanged: (val) => _questions.ciudadesVisitadas = val,
          ),
        ],
      ),
    );
  }

  Widget _contacto(){
    Widget fecha = Container();

    if(_enContacto)
      fecha = Container(
        width: _screenWidth * 0.40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(Translations.of(context).text('date'), style: greyText.copyWith(fontWeight: FontWeight.w200),),
            TextFormField(
              controller: _ctrlFechaContacto,
              readOnly: true,
              onTap: ()=> _selectDate(context),
            )
          ],
        ),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SwitchListTile(
          title: Text(Translations.of(context).text('enContacto'), style: greyText.copyWith(fontWeight: FontWeight.w200), textAlign: TextAlign.justify,),
          value: _enContacto,
          onChanged: (val) => setState(() {
              _enContacto = val;
              _questions.enContacto = val;

              if(!val){
                _ctrlFechaContacto.text = '';
                _questions.fechaContacto = '';
              }
          }),
        ),
        SizedBox(height: 10.0,),
        fecha,
        SizedBox(height: 20.0,),
      ],
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime ahora = new DateTime.now();
    DateTime firstDate = new DateTime(ahora.year - 50, ahora.month, ahora.day);
    DateTime lastDate = ahora;

    final DateTime picked = await showDatePicker(
      context: context,
      locale: Translations.of(context).locale,
      initialDate: (_questions?.fechaContacto != null && _questions.fechaContacto.isNotEmpty) ? fechaByString(_questions?.fechaContacto): ahora,
      firstDate: firstDate,
      lastDate: lastDate
    );
     
    if (picked != null) {
      setState(() {
        _questions.fechaContacto = "${picked.year}-${picked.month}-${picked.day}";
        _ctrlFechaContacto.text ="${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Widget _controlSaludLabel(){
    return Text(Translations.of(context).text('control_salud'),
      style: greyText.copyWith(fontWeight: FontWeight.w200),
      textAlign: TextAlign.center,
    );
  }

  Widget _controlSaludInstruction(){
    return Text(Translations.of(context).text('control_salud_instruccion'),
      style: greyText.copyWith(fontWeight: FontWeight.w200),
      textAlign: TextAlign.justify,
    );
  }

  Widget _temperatura(){
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: SwitchListTile(
          title: Text(Translations.of(context).text('temperatura'), style: greyText.copyWith(fontWeight: FontWeight.w200), textAlign: TextAlign.justify,),
          value: _temp,
          onChanged: (val) => setState(() {
              _temp = val;
              _questions.temperatura = val;
          }),
        ),
    );
  }
 
  Widget _tos(){
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: SwitchListTile(
          title: Text(Translations.of(context).text('tos'), style: greyText.copyWith(fontWeight: FontWeight.w200), textAlign: TextAlign.justify,),
          value: _ts,
          onChanged: (val) => setState(() {
              _ts = val;
              _questions.tos = val;
          }),
        ),
    );
  }

  Widget _malestar(){
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: SwitchListTile(
          title: Text(Translations.of(context).text('malestar'), style: greyText.copyWith(fontWeight: FontWeight.w200), textAlign: TextAlign.justify,),
          value: _mal,
          onChanged: (val) => setState(() {
              _mal = val;
              _questions.malestarGeneral = val;
          }),
        ),
    );
  }
  
  Widget _respirar(){
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: SwitchListTile(
          title: Text(Translations.of(context).text('dificultadRespirar'), style: greyText.copyWith(fontWeight: FontWeight.w200), textAlign: TextAlign.justify,),
          value: _dificultad,
          onChanged: (val) => setState(() {
              _dificultad = val;
              _questions.dificultadRespirar = val;
          }),
        ),
    );
  }

  Widget _sintomas(){
     Widget sintomas = Container();

    if(_otrosSintomas)
      sintomas = TextFormField(
        controller: _ctrlSintomas,
        decoration: InputDecoration(
          icon: Text(Translations.of(context).text('cuales')+":", style: greyText.copyWith(fontWeight: FontWeight.w200), textAlign: TextAlign.justify,)
        ),
        onChanged: (val)=> _questions.otrosSintomas = val,
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SwitchListTile(
          title: Text(Translations.of(context).text('otrosSintomas'), style: greyText.copyWith(fontWeight: FontWeight.w200), textAlign: TextAlign.justify,),
          value: _otrosSintomas,
          onChanged: (val) => setState(() {
              _otrosSintomas = val;

              if(!val){
                _ctrlSintomas.text = '';
                _questions.otrosSintomas = '';
              }
          }),
        ),
        SizedBox(height: 10.0,),
        sintomas,
        SizedBox(height: 20.0,),
      ],
    );
  }

   Widget  _buttonGuardar(){
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
        onPressed: (){
          _pmsBloc.setCuestionarioCovid(_questions);

          if(_pmsBloc.getposition() == -1)
            Navigator.pushReplacementNamed(context, 'infoTitular');
          else
            Navigator.pushReplacementNamed(context, 'infoAdicional');
        },
        child: Text(
          Translations.of(context).text('save'),
          style: TextStyle(fontSize: 20.0, fontFamily: "Montserrat"),
        ),
      )
    );
  }

}