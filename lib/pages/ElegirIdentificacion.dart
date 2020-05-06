import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:precheckin/pages/identificacion/PrimerDocumento.dart';

class ElegirIdentificacion extends StatefulWidget {
  @override
  _ElegirIdentificacionState createState() => _ElegirIdentificacionState();
}
class TipoDoc {
  String name;
  int index;
  Icon icon;
  TipoDoc({this.name, this.index, this.icon});
}
class _ElegirIdentificacionState extends State<ElegirIdentificacion> {
  String name;
  int index;
  String nameItem ;
  int idItem ;
  
   List<TipoDoc> docList = [
    TipoDoc(
      index: 0,
      name: "Pasaporte",
      icon: Icon(FontAwesomeIcons.circle)
    ),
    TipoDoc(
      index: 1,
      name: "Documento de identidad",
      icon: Icon(FontAwesomeIcons.circle)
    ),
  ];

  _onChange(String nombre, int index){
      nameItem = nombre;
      idItem = index;
      docList[index].icon = Icon(FontAwesomeIcons.checkCircle);
      //setState(() {
      docList.forEach((d){
        if(d.index!=index){
          d.icon = Icon(FontAwesomeIcons.circle);
        }
      });
    //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Column(
      children: <Widget>[
          _headerText(),
          _lista(),
          _aviso(),
          _buttonContinuar()
        ],
      )
    );
  }

  Widget _aviso(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child:Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            child: Icon(Icons.lock)
          ),
          Expanded(
            child: Text('No compartiremos tus documentos de identificación con otro usuario')
          )
        ],
      )
    );
  }

  Widget _lista(){
    return Expanded(
          child: ListView.builder(
          itemCount: docList.length,
          itemBuilder: (context, item) {
            TipoDoc doc = docList[item];
            return  Container(
              width: MediaQuery.of(context).size.width-40,
              decoration: _decoration(),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(doc.name),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap:(){
                        //setState(() {
                          nameItem = doc.name;
                          idItem = item;
                          //docList[idItem].icon = Icon(FontAwesomeIcons.checkCircle);
                          setState(() {
                           docList.forEach((d){
                            if(d.index!=item){
                              d.icon = Icon(FontAwesomeIcons.circle);
                            }else{
                              d.icon = Icon(FontAwesomeIcons.checkCircle, color: Colors.green,);
                            }
                          }); 
                        });
                      },
                      splashColor: Colors.grey,
                      child: doc.icon
                    ),
                  ),
                ],
              )
            );
          },
        ),
    );
  }

  Widget _headerText(){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        'Selecciona un tipo de documento de identificación para añadir',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600,)
      ),
    );
  }

  Widget _appbar() {
    return new AppBar(
      backgroundColor: Colors.deepOrange,
      leading: Container(),
      title: Text('Documentos de Identificación'),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              size: 26.0,
            ),
          )
        ),
      ],
    );
  }

  BoxDecoration _decoration (){
    return BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey, width: 1))
    );
  }


  Widget  _buttonContinuar(){
    return Container(
      width: MediaQuery.of(context).size.width-20,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      color: Colors.white,
      child:FlatButton(
        color: Colors.deepOrange,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        splashColor: Colors.orange,
        onPressed: () {
          print('idItem ${idItem.toString()}');
          print('idItem ${nameItem.toString()}');
           Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => PrimerDocumento(),
            )
          ); 
        },
        child: Text(
          "Continuar",
          style: TextStyle(fontSize: 20.0),
        ),
      )
    );
  }
}
