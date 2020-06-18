import 'package:flutter/material.dart';

import 'package:precheckin/providers/pais_provider.dart';
import 'package:precheckin/models/paises_model.dart';

///Crear un DropdownButton con una lista de paises.
///
///Consulta el servicio getListaPaises del PMS y crea un
///DropdownButton a parir de los resulados obtenido. Para
///funcionar requiere de los parametros: String [hotel], 
///es el número de hotel de la reserva(parametro obligatorio),
///String [valorInicial] clave del pais que trar la 
///reservacion(parametro obligatorio) y Function [change],
///es la funcion(pasada por referencia) que se ejecutará cuando 
///cambie la seleccion del DropdownButton(parametro obligatorio)
class PaisesWidget extends StatelessWidget {
  final String hotel;
  final String valorInicial;
  final Function change;

  PaisProvider _provider = new PaisProvider();
  List<Pais> _paises;


  PaisesWidget({
    @required this.hotel,
    @required this.valorInicial,
    @required this.change
  });


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _provider.getListaPaises(hotel),
      builder: (BuildContext context, AsyncSnapshot<List<Pais>> snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        
        _paises = snapshot.data;

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

    try {
      _paises.forEach( (pais) {
        lista.add(DropdownMenuItem(
          child: Text(pais.nombrepais ?? ''),
          value: pais.clavepais ?? '',
        ));
      });
    } catch(e) {
      print("Error en la lista de paises: $e");
      lista = [];
    }
   

    return lista;
  }
}