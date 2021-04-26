import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListaEquipos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<String> _equipos=["equipo1","equipo 2", "equipo3"];
    return
      ListView(
          children: <Widget>[
            Center(
              child: Text("Lista de Equipos", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            ),
            DataTable(columns: [
              DataColumn(label: Text("Nombre")),
              DataColumn(label: Text("Tipo")),
              DataColumn(label: Text("Usuario actual")),
              DataColumn(label: Text("Lugar")),
              DataColumn(label: Text("Modelo")),
              DataColumn(label: Text("Estado")),
              DataColumn(label: Text("Acción")),
            ], rows: _createRow(_equipos))

          ]);
  }
  List<DataRow> _createRow (List<String>equipos){
    List<DataRow> rows= List<DataRow>();
    for(String a in equipos){
      rows.add(DataRow(cells: [
        DataCell(Text(a)),
        DataCell(Text('type')),
        DataCell(Text('current user')),
        DataCell(Text('place')),
        DataCell(Text('model')),
        DataCell(Text('state')),
        DataCell(Text('botones xd'))]));
    }
    return rows;
  }


}