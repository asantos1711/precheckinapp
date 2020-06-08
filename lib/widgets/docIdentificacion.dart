
import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/acompaniantes_model.dart';
import 'package:precheckin/pages/ElegirIdentificacion.dart';
import 'package:precheckin/styles/styles.dart';
import 'package:precheckin/tools/translation.dart';

class DocIdentificacion extends StatefulWidget {
  Acompaniantes acompaniantes;

  DocIdentificacion({
    this.acompaniantes
  });

  @override
  _DocIdentificacionState createState() => _DocIdentificacionState();
}

class _DocIdentificacionState extends State<DocIdentificacion> {
  bool condicion = false;
  Acompaniantes acompaniantes;
  String fullImage;
  Icon icono = Icon(Icons.camera_alt, color: Color.fromRGBO(0, 165, 227, 1), size: 30);

  @override
  void initState() {
    acompaniantes = this.widget.acompaniantes; //.acompaniantes[index];
    condicion = _condicionIcono();

    if(condicion)
      icono = Icon(Icons.check_circle_outline, color:Colors.green, size: 30,);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      acompaniantes = acompaniantes;
      condicion     = _condicionIcono();
    });

    return Card(
      elevation: 3.0,
      child: ListTile(
        title: Text(Translations.of(context).text('doc_identificacion'),
          style: lightBlueText.copyWith(fontSize: 15),
          maxLines: 2,
        ),
        trailing: icono,
        onTap: (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                ElegirIdentificacion(
                  acompaniantes: acompaniantes,
                  func:(aco){
                    setState(() {
                      acompaniantes=aco;
                      condicion = _condicionIcono();
                    });
                  }
                ),
            )
          ); 
        },
      ),
    );
  }

  bool _condicionIcono() => (acompaniantes.imageback!=null
    &&acompaniantes.imagefront !=null
    &&acompaniantes.imagefront !=''
    &&acompaniantes.imageback !=''
  );

}