import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListaEquipos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
          ], rows: [
            //TODO: hacer dinámicamente hehe
            DataRow(cells: [
              DataCell(Text('name')),
              DataCell(Text('type')),
              DataCell(Text('curretly user')),
              DataCell(Text('place')),
              DataCell(Text('model')),
              DataCell(Text('state')),
              DataCell(Text('botones xd'))
            ])
          ])
        ],
      );
  }



}