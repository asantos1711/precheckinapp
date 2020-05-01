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
  final String valorInicial;
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

        return _crearDropDown();
      },
    );
  }


  Widget _crearDropDown() {
    return DropdownButton(
      isExpanded: true,
      items: _getItems(),
      value: valorInicial,
      onChanged: change,
    );
  }

  //Forma la lista de los items apartir de la lista de paises obtenida del provider
  List<DropdownMenuItem<String>> _getItems() {
    List<DropdownMenuItem<String>> lista = new List();

    _estados.forEach( (estado) {
      lista.add(DropdownMenuItem(
        child: Text(estado.nombreestado),
        value: estado.claveestado,
      ));
    });

    return lista;
  }

}