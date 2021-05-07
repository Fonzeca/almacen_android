import 'package:almacen_android/packages/tecnica/bloc/bloc_listaEquipos_bloc.dart';
import 'package:almacen_android/packages/tecnica/model/equipo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListaEquipos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    List<Equipo> _equipos=[];
    return BlocBuilder<ListaEquiposBloc,ListaEquiposState>(builder: (context,state){
      if(_equipos == null){
        BlocProvider.of<ListaEquiposBloc>(context).add(ListaEquiposEventListarEquipos());
        _equipos=state.listaEquipos;
        return Container();
      }else{
        return  SingleChildScrollView(
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
        );
      }
    });
  }
}

List<DataRow> _createRow (List<Equipo>equipos){
  List<DataRow> rows= [];
  for(Equipo a in equipos){
    rows.add(DataRow(cells: [
      DataCell(Text(a.nombre)),
      DataCell(Text(a.tipo.nombre)),
      DataCell(Text(a.usuario)),
      DataCell(Text(a.lugar.nombre)),
      DataCell(Text(a.modelo)),
      DataCell(Text(a.estado)),
      DataCell(Text('botones '))]));
  }
  return rows;
}