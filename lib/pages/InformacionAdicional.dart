import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/models/reserva_model.dart';
import 'package:precheckin/pages/ElegirIdentificacion.dart';
import 'package:precheckin/persitence/qr_persistence.dart';
import 'package:precheckin/preferences/user_preferences.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/widgets/ColumnBuilder.dart';
import 'package:precheckin/widgets/btn_encuesta_salud_widget.dart';
import 'package:precheckin/widgets/card_acompanante.dart';
import 'package:precheckin/widgets/check_text_bold.dart';
import 'package:precheckin/widgets/custom_signature.dart';
import 'package:precheckin/widgets/docIdentificacion.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:signature/signature.dart';
import 'package:precheckin/utils/tools_util.dart' as tools;
import 'ViewWebView.dart';
import 'package:precheckin/widgets/signature_widget.dart';

class InformacionAdicional extends StatefulWidget {
  @override
  _InformacionAdicionalState createState() => _InformacionAdicionalState();
}

class _InformacionAdicionalState extends State<InformacionAdicional> {
  double width;
  double height;
  bool _enableButton = true;
  bool _reglaHotelBool = true;
  bool _avisoPrivaBool = true;
  bool _recibirInfoBool = true;
  bool _poliProceBool = true;
  bool _reglasCovid = true;
  bool _bloquear = false;
  bool _agregarAcompaniantes = false;
  PMSBloc _pmsBloc;
  QRPersistence _persistence = new QRPersistence();
  UserPreferences _pref;
  List<String> _qr;
  DateTime dateAco = new DateTime.now();
  TextEditingController textController = new TextEditingController(text: '');
  Reserva _reserva;  
  Result _result;  
  Map<Acompaniantes,SignatureController> mapControllerSiganture = Map<Acompaniantes,SignatureController>();

  final SignatureController _controller = SignatureController();



  @override
  void initState() {
    super.initState();
    
    _controller.addListener((){});
    _pmsBloc = new PMSBloc();
    _pref    = new UserPreferences();
    _qr      = _persistence.qr;
    _reserva = _pmsBloc.reserva;
    _result  = _pmsBloc.result;

    _pmsBloc.initCheckbox = 1;
    _enableButton = _poliProceBool && _reglaHotelBool & _avisoPrivaBool && _reglasCovid;
  }

  _botonDisable()=> setState(() =>_enableButton = _poliProceBool && _reglaHotelBool && _avisoPrivaBool && _reglasCovid);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width  = MediaQuery.of(context).size.width;
    _agregarAcompaniantes = _pmsBloc.habilitarAddAcompaniantes;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) 
          currentFocus.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                _reglaHotel(),
                _poliProce(),
                _avisoPriva(),
                _reglasCOVID(),
                _recibirInfo(),
                _signatureTitular(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DocIdentificacion(acompaniantes: _result.titular)
                ),
                _tituloAcompa(),
                _acompanantes(),
                _agregarAco(),
                _buttonFinalizar(),
              ],
            ),
            tools.bloqueaPantalla(_bloquear)
          ],
        )
      )
    );
  }

  Widget _appBar() {
    return AppBar(
      leading: Container(),
      title:Container(
        width: MediaQuery.of(context).size.width/0.7,
          child: AutoSizeText(
            Translations.of(context).text('info_acompanantes'),
            style: appbarTitle,
            maxLines: 2,
            maxFontSize: 25.0 ,
            minFontSize: 5.0 ,
          )
        ),
      centerTitle: true,
    );
  }

  Widget _reglaHotel() {
    return CheckTextBold(
      width: width,
      onChange:(boo){
        setState(() {
          _reglaHotelBool = !_reglaHotelBool;
          _pmsBloc.reglamento = toInt(_reglaHotelBool);
        });
        _botonDisable();
      } ,
      value: _reglaHotelBool,
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('reglamento_hotel'),
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: 
              (context, animation1, animation2) => 
              ViewWebView(
                valor : 'reglamento_hotel',
                politicas: _reserva.politicas,
                title: Translations.of(context).text('reglamento_hotel'),
              ),
            ));
      },
    );
  }

  Widget _poliProce() {
    return CheckTextBold(
      width: width,
      onChange:(boo){
        setState(() {
          _poliProceBool = !_poliProceBool;
          _pmsBloc.politicasProcesos = toInt(_poliProceBool);
        });
        _botonDisable();
      } ,
      value: _poliProceBool,
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('politicas_procedimientos'),
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: 
              (context, animation1, animation2) => 
              ViewWebView(
                valor: 'politicas_procedimientos',
                politicas: _reserva.politicas,
                title:Translations.of(context).text('politicas_procedimientos'),
              ),
            ));
      },
    );
  }

  Widget _avisoPriva() {
    return CheckTextBold(
      width: width,
      onChange:(boo){
        setState(() {
          _avisoPrivaBool = !_avisoPrivaBool;
          _pmsBloc.avisoPrivacidad = toInt(_avisoPrivaBool);
        });
        _botonDisable();
      } ,
      value: _avisoPrivaBool,
      text: Translations.of(context).text('acepto_deacuerdo'),
      textBold: Translations.of(context).text('aviso_privacidad'),
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => 
              ViewWebView(
                valor: 'aviso_privacidad',
                politicas: _reserva.politicas,
                title: Translations.of(context).text('aviso_privacidad'),
              ),
            ));
      },
    );
  }

  Widget _reglasCOVID() {
    return CheckTextBold(
      width: width,
      onChange:(boo){
        setState(() {
          _reglasCovid = !_reglasCovid;
          _pmsBloc.reglasCovid = toInt(_reglasCovid);
        });
        _botonDisable();
      } ,
      value: _reglasCovid,
      text: "Reglamento COVID",
      textBold: "",
      onTap: () {},
    );
  }

  Widget _recibirInfo() {
    return CheckTextBold(
        width: width,
        onChange:(boo){
          setState(() {
            _recibirInfoBool = !_recibirInfoBool;
            _pmsBloc.promocion = toInt(_recibirInfoBool);
          });
        },
        textBold: '',
        text: Translations.of(context).text('recibir_info'),
        onTap: () {},
        value: _recibirInfoBool
    );
  }

  Widget _signatureTitular() {
    _controller.addListener(() async {
        var data = await _controller.toPngBytes();
        if(data != null)
          _pmsBloc.signTitular = base64.encode(data);
    });

    return Container(
      margin: EdgeInsets.symmetric(vertical:10.0, horizontal:10.0),
      child: SignatureWidget(
        img: _pmsBloc.signTitular ?? "",
        title:Translations.of(context).text('ingresa_firma_titular'),
        controller: _controller,
      ),
    );
  }

  Widget _tituloAcompa() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, right: 10),
      width: width - 20,
      child: Text(
        Translations.of(context).text('acompanantes'),
        style: TextStyle(
          fontSize: 25,
        ),
      ));
  }
  
  Widget _acompanantes() {
    /* List<Widget> widgets = [];

    _pmsBloc.acompaniantes.forEach( (acompaniante){
      SignatureController _controllerSignature = new SignatureController();

      _controllerSignature.addListener(()async{
        var data = await _controllerSignature.toPngBytes();
        if(data != null)
          acompaniante.imagesign = base64.encode(data);
      });
      acompaniante.imagefront = null;
      Widget widget = CardAcompanante(
        acompaniante: acompaniante,
        signature:  Container(
          margin: EdgeInsets.symmetric(vertical:10.0, horizontal:10.0),
          child: SignatureWidget(
            img: acompaniante.imagesign ?? "",
            title:"",
            controller: _controllerSignature,
          )
        )
      );

      widgets..add(widget);

    } ); */
    
    this.setState(() {
      _pmsBloc.acompaniantes = _pmsBloc.acompaniantes;
    }); 
    return ColumnBuilder(
      itemCount: _pmsBloc.acompaniantes.length,
      itemBuilder: (context,index){
        SignatureController _controllerSignature = new SignatureController();

        _controllerSignature.addListener(()async{
          var data = await _controllerSignature.toPngBytes();
          if(data != null)
            _pmsBloc.acompaniantes[index].imagesign = base64.encode(data);
        });
        //_pmsBloc.acompaniantes[index].imagefront = null;
        return Column(
          children: <Widget>[
            CardAcompanante(
              acompaniante: _pmsBloc.acompaniantes[index],
              signature:  Container(
                margin: EdgeInsets.symmetric(vertical:10.0, horizontal:10.0),
                child: SignatureWidget(
                  img: _pmsBloc.acompaniantes[index].imagesign ?? "",
                  title:"",
                  controller: _controllerSignature,
                )
              )
            ),
            _buttonEncuentaCovid(index)
          ],
        ); 
      }
    );
  }

  Widget  _buttonEncuentaCovid(int position){
    return Center(
      child:  BtnEncuestaSalud(
        pmsBloc: _pmsBloc,
        posicion: position,
      ),
    );
  }
 
  Widget _agregarAco() {
    if(!_agregarAcompaniantes)
      return Container();

    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: MaterialButton(
        color: Color.fromRGBO(0, 165, 227, 1),
        textColor: Colors.white,
        child: Icon(FontAwesomeIcons.plus,size: 24,),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
        onPressed: () => Navigator.pushNamed(context, "addHuesped")
      )
    );
  }

  Widget _buttonFinalizar() {
    return Container(
      width: width - 20,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      margin: EdgeInsets.symmetric(vertical: 30),
      color: Colors.white,
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.grey,
        onPressed: _enableButton == false ? null : () =>_saveData(),
        child: Text(Translations.of(context).text('finalizar'),
          style: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
        ),
      ));
  }

  Future _saveData() async {
    if(!_pmsBloc.verificarEncuestas())
      tools.showAlert(context, Translations.of(context).text("all_cuestionary_required"));
    else{

      _bloquearPantalla(true);
      
      bool status = await _pmsBloc.actualizaHospedaje();

      _bloquearPantalla(false);

      if(!status)
        tools.showAlert(context, "No se logro guardar los datos");
      else {
        if(!_qr.contains(_reserva.codigo))
          _qr.add(_reserva.codigo);

        _persistence.qr = _qr;

        if(!_pref.tieneLigadas) 
          Navigator.pushNamed(context, "verQR", arguments: _reserva.codigo);
        else {
          List<String> procesados = _pref.reservasProcesadas;
          if(_pref.reservasProcesadas.indexOf(_result.idReserva.toString()) == -1)
              procesados.add(_result.idReserva.toString());

          _pref.reservasProcesadas = procesados;

          Navigator.pushNamed(context, 'litaReserva', arguments: _reserva);
        }
      }
    }

  }

  void _bloquearPantalla(bool status) => setState(() => _bloquear = status);

  int toInt(bool val) => val ? 1 : 0;






  
  bool _condicionAgregarAcom(String nuevaEdad){
    int adultos = 1;//inicio en 1 por el titular
    int menores=0;
    int densiadultos = 1;//inicio en 1 por el titular
    int densimenores=0;
    int edad;
    int _nuevaEdad = int.parse(nuevaEdad);
    _reserva.result.acompaniantes.forEach((element) { 
      edad =int.parse(element.edad);
      if(edad<18){
        menores++;
      }else if(edad>=18){
        adultos++;
      }
    });
    print("Adultos:  $adultos");
    print("Menore:  $menores");

    double densidadTotal  = double.parse(_reserva.result.tipoHabitacion.densidad) ;
    densiadultos = densidadTotal.floor();
    densimenores = ((densidadTotal-densiadultos)*10).floor();

    print('desnsidad ${_reserva.result.tipoHabitacion.densidad}');
    print("densiAdultos:  $densiadultos");
    print("densiMenore:  $densimenores");

    if(adultos>= densiadultos && menores>=densimenores){
      print("no se puede agregar acompañante");
      _toast(Translations.of(context).text('max_acompanantes'));//Toast
      return false;
    }


    if(_nuevaEdad<18){
      menores++;
      if(menores <= densimenores){
        print("se puede agregar menor ");

        return true;
      }else{
        print("no se puede agregar menor");
        _toast(Translations.of(context).text('max_menores'));//Toast
        return false;
      }
    }else if(_nuevaEdad>=18){
      adultos++;
      if(adultos <= densiadultos){
        print("se puede agregar mayor");
        return true;
      }else{
        print("no se puede agregar mayor");
        _toast( Translations.of(context).text('max_adultos'));//Toast
        return false;
      }
    }

  }

  Widget _toast(String text){
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 20.0
    );
  }

  void _onAlertWithCustomContentPressed(context) {
    Acompaniantes _aco = new Acompaniantes();
    _aco.fechanac = new DateTime.now().toString();
    _aco.club = _result.idClub;
    _aco.idcliente = _result.idCliente;
    _aco.idacompaniantes = 0;
    _aco.istitular = false;
    
    SignatureController _sigController = new SignatureController();
    _sigController.addListener(() async {
        var data = await _sigController.toPngBytes();
        _aco.imagesign = base64.encode(data);
    });
    Alert(
        closeFunction:(){
          print('Se cerró la alerta');
        } ,
        context: context,
        title: "Agregar acompañante",
        content: Column(
          children: <Widget>[
            CardAcompanante(
              acompaniante: _aco,
              signature: CustomSignature(
                controller: _sigController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(FontAwesomeIcons.exclamationCircle , color: Colors.red,size: 15, ),
                Expanded(
                  child: Text(
                    Translations.of(context).text('cargo')+''+Translations.of(context).text('cargo_valor'), 
                    style: TextStyle(color: Colors.red, fontSize: 15),
                    maxLines: 2,
                    ),  
                )
              ],
            )
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.white,
            onPressed: () {
              setState(() {
                
                //if(_condicionAgregarAcom(_aco.edad)){
                  mapControllerSiganture[_aco] =_sigController;
                  _aco.istitular = false;
                  _result.acompaniantes.add(_aco);
                  mapControllerSiganture[_aco] =_sigController;
                //}
                
              });
              Navigator.pop(context);
              /*if(_condicionAgregarAcom(_aco.edad))
                Fluttertoast(

                );*/
            } ,
            child: Text(
              Translations.of(context).text('agregar'),
              style: TextStyle(color: Colors.blueAccent, fontSize: 20),
            ),
          )
        ]).show();
  }

  Widget _docuTitular() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10),
        width: width - 20,
        child: Row(
          children: <Widget>[
            Container(
                width: ((width - 20) / 3) * 2,
                child: Text(
                  'Documento de identificación',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                )),
            Container(
                alignment: Alignment.centerRight,
                width: (width - 20) / 3,
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: (){
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) => ElegirIdentificacion(
                          acompaniantes: _reserva.result.titular,
                        ),
                      )
                    );
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Color(0xFFE87200),
                    size: 30,
                  )
                )
              )
          ],
        ));
  }
}