import 'package:flutter/material.dart';
import 'package:precheckin/models/commons/aerolinea_model.dart';


class AerolineasSearch extends SearchDelegate<Aerolinea> {
  List<Aerolinea> aeroLineas;

  AerolineasSearch({ this.aeroLineas });

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: ()=>close(context, null),
    );
  }
  
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las Acciones del AppBar
    return [ 
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = '';
        })
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Container();
  }

  
  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencinas que aparecen cuando la persona escribe

    final listaSugerida = ( query.isEmpty ) ? aeroLineas : aeroLineas.where( (a) => a.name.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.local_airport),
          title: Text(listaSugerida[index].name),
          onTap: ()=>close(context, listaSugerida[index]),
        );
     },
    );
  }
}