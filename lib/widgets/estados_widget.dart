import 'package:flutter/material.dart';
import 'package:precheckin/models/estados_model.dart';
import 'package:precheckin/providers/estado_provider.dart';


///Crear un DropdownButton con una lista de estados.
///
///Consulta el servicio getListaEstados del PMS y crea un
///DropdownButton a parir de los resulados obtenido. Para
///funcionar requiere de los parametros: String [hotel], 
///es el número de hotel de la reserva(parametro obligatorio),
///String [valorInicial] clave del pais que trar la 
///reservacion(parametro obligatorio), String [pais], el 
/// pais de origen del huesped y Function [change],
///es la funcion(pasada por referencia) que se ejecutará cuando 
///cambie la seleccion del DropdownButton(parametro obligatorio)
class EstadosWidget extends StatelessWidget {
  final String hotel;
  final String pais;
  String valorInicial;
  final Function change;

  EstadoProvider _provider = new EstadoProvider();
  List<Estado> _estados;

  
  EstadosWidget({
    @required this.hotel,
    @required this.pais,
    @required this.valorInicial,
    @required this.change
  });

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _provider.getListaEstados(hotel:hotel, pais: pais),
      builder: (BuildContext context, AsyncSnapshot<List<Estado>> snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        
        _estados = snapshot.data;
        valorInicial = _verificarValorInicial(valorInicial);

        return DropdownButton(
          isExpanded: true,
          items: _getItems(),
          value: valorInicial,
          onChanged: change,
        );
      },
    );
  }


  //Forma la lista de los items apartir de la lista de estados obtenida del provider
  List<DropdownMenuItem<String>> _getItems() {
    List<DropdownMenuItem<String>> lista = new List();

    try{
      _estados.forEach( (estado) {
        lista.add(DropdownMenuItem(
          child: Text(estado.nombreestado ?? ''),
          value: estado.claveestado ?? '',
        ));
      });
    } catch(e){
      print("Error en la lista de paises: $e");
      lista = [];
    }
    

    return lista;
  }


  //Valida que la clve de estado que biene en valor inicial este entre los que trar e
  //servicio de estadps.
  String _verificarValorInicial(String val){
    String e = "-";
    
    for (var i = 0; i < _estados.length; i++) {
      if(val == _estados[i].claveestado) {
        e = val;
        break;
      }
    }

    return e;
  }

}