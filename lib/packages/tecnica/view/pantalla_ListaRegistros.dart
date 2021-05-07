import 'package:almacen_android/packages/tecnica/model/registro.dart';
import 'package:flutter/material.dart';

class ListaRegistros extends StatelessWidget{
  bool admn;
  ListaRegistros ({Key key, @required this.admn}):super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Registro> _registros=[];
    return
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(8.0),
                child: DataTable(columns: [
                  DataColumn(label: Text("Fecha")),
                  DataColumn(label: Text("Entrada / Salida")),
                  DataColumn(label: Text("Usuario")),
                  DataColumn(label: Text("Equipo")),
                ], rows: _createRow(_registros)),
              ),
            )

    ;
  }
  List<DataRow> _createRow (List<Registro>registros){
    List<DataRow> rows= [];
    for(Registro a in registros){
      rows.add(DataRow(cells: [
        DataCell(Text(a.fecha)),
        DataCell(Text(a.entrada?"Entrada":"Salida")),
        DataCell(Text(a.usuario)),
        DataCell(Text(a.equipo.nombre))]));
    }
    return rows;
  }


}