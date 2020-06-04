import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/info_hospedaje.dart';
import 'package:precheckin/widgets/info_titular_widget.dart';
import 'package:precheckin/widgets/info_contacto.dart';
import 'package:precheckin/widgets/info_vuelo_widget.dart';
import 'package:precheckin/blocs/pms_bloc.dart';

class HabitacionTitular extends StatefulWidget {
  @override
  _HabitacionTitularState createState() => _HabitacionTitularState();
}

class _HabitacionTitularState extends State<HabitacionTitular> with TickerProviderStateMixin{
  PMSBloc _pmsBloc;
  AnimationController _controller;
  static const List<String> _funcionList = const [ "1","2" ];
  Map<String,String> _opcionesFloat = new  Map<String,String>();

  @override
  void initState() {
    super.initState();
   
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _pmsBloc    = new PMSBloc();
  }

  @override
  Widget build(BuildContext context) {
    _opcionesFloat["1"] = Translations.of(context).text('opcion_duda').toString();
    _opcionesFloat["2"] = Translations.of(context).text('opcion_error').toString();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: ListView(
        children: <Widget>[
          _seccionReservacion(),
          _seccionTitular(),
          _seccionContacto(),
          _buttonEncuentaCovid(),
          _seccionVuelo(),
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

  Widget _seccionTitular(){
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: InfoTitular(
        pmsBloc: _pmsBloc
      )
    );
  }
  
  Widget _seccionContacto(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      child: InfoContacto(
        block: _pmsBloc,
      )
    );
  }

  Widget  _buttonEncuentaCovid(){
    return Center(
      child: FlatButton(
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        color: Color(0xff3F5AA6),
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text(Translations.of(context).text('covid_cuestionary')),
        onPressed: (){
          _pmsBloc.position = -1;
          Navigator.pushNamed(context, "questionsCovid");
        },
      ),
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
        onPressed: () => Navigator.pushNamed(context, 'infoAdicional'),
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