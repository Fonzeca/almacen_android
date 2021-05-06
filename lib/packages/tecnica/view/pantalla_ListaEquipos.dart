import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListaEquipos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<String> _equipos=["equipo1","equipo 2", "equipo3"];
    return

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                  sortColumnIndex: 1,
                    columns: [
                  DataColumn(label: Text("Nombre")),
                  DataColumn(label: Text("Tipo")),
                  DataColumn(label: Text("Usuario actual")),
                  DataColumn(label: Text("Lugar")),
                  DataColumn(label: Text("Modelo")),
                  DataColumn(label: Text("Estado")),
                  DataColumn(label: Text("Acción")),
                ], rows: _createRow(_equipos)),
              ),
            )


    ;
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
        DataCell(Text('botones '))]));
    }
    return rows;
  }


}