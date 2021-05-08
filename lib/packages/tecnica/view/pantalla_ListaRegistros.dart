import 'package:almacen_android/packages/tecnica/bloc/bloc_listaRegistros_bloc.dart';
import 'package:almacen_android/packages/tecnica/model/registro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListaRegistros extends StatelessWidget{
  bool admn;
  ListaRegistros ({Key key, @required this.admn}):super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Registro> _registros=[];
    return

      BlocBuilder<ListaRegistrosBloc, ListaRegistrosState>(builder: (context, state){
        if(_registros==null){
          BlocProvider.of<ListaRegistrosBloc>(context).add(ListaRegistrosEventListarRegistros());
          _registros=state.registros;
          return Container();
        }else{
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8.0),
              child: admn?DataTable(columns: [
                DataColumn(label: Text("Fecha")),
                DataColumn(label: Text("Equipo")),
                DataColumn(label: Text("Usuario")),
                DataColumn(label: Text("Entrada / Salida")),
              ], rows: _createRow(_registros,admn)):
              DataTable(columns: [
                DataColumn(label: Text("Fecha")),
                DataColumn(label: Text("Equipo")),
                DataColumn(label: Text("Entrada / Salida")),
              ], rows: _createRow(_registros,admn)),
            ),
          )
          ;
        }
      });

  }
  List<DataRow> _createRow (List<Registro>registros, bool adm){
    List<DataRow> rows= [];
    if(adm){
      for(Registro a in registros){
        rows.add(DataRow(cells: [
          DataCell(Text(a.fecha)),
          DataCell(Text(a.equipo.nombre)),
          DataCell(Text(a.usuario)),
          DataCell(Text(a.entrada?"Entrada":"Salida")),
        ]));
      }
    }else{
      for(Registro a in registros){
        rows.add(DataRow(cells: [
          DataCell(Text(a.fecha)),
          DataCell(Text(a.equipo.nombre)),
          DataCell(Text(a.entrada?"Entrada":"Salida")),
        ]));
      }
    }
    return rows;
  }


}