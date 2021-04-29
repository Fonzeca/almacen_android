import 'package:flutter/material.dart';

class ListaRegistros extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<String> _registros=["registro 1","registro 2", "registro 3"];
    return
      ListView(
          children: <Widget>[
            Center(
              child: Text("Lista de Registros", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            ),
            DataTable(columns: [
              DataColumn(label: Text("Fecha")),
              DataColumn(label: Text("Entrada / Salida")),
              DataColumn(label: Text("Usuario")),
              DataColumn(label: Text("Equipo")),
            ], rows: _createRow(_registros))

          ]);
  }
  List<DataRow> _createRow (List<String>registros){
    List<DataRow> rows= List<DataRow>();
    for(String a in registros){
      rows.add(DataRow(cells: [
        DataCell(Text('26/04/21')),
        DataCell(Text('entrada o salida')),
        DataCell(Text('user')),
        DataCell(Text('equipo 1'))]));
    }
    return rows;
  }


}