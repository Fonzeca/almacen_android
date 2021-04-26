import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/pedido.dart';
import 'package:flutter/material.dart';

class ListaPedidos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Servidor _servidor = Servidor();
    // List<Pedido> _pedidos;
    // _servidor.listarPedidos().then((value) => _pedidos=value);
    List<String> _pedidos= ["Pedido 1", "Pedido 2", "Pedido 3"];

    return ListView(
        children: <Widget>[
          Center(
            child: Text("Lista de Pedidos", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
          ),
          DataTable(columns: [
            DataColumn(label: Text("Fecha")),
            DataColumn(label: Text("Usuario")),
            DataColumn(label: Text("Estado")),
            DataColumn(label: Text("Acción"))
          ], rows: _createRow(_pedidos))

        ]);
  }

}
/**
 * TODO: volver a pedir lista de Pedido
 */
List<DataRow> _createRow (List<String>pedidos){
  List<DataRow> rows= List<DataRow>();
  // for(Pedido p in pedidos){
  //
  //   DataRow(cells: [
  //     DataCell(Text(p.fecha)),
  //     DataCell(Text(p.usuario)),
  //     DataCell(Text(p.estadoPedido.nombreEstado)),
  //     DataCell(Text('botones xd'))
  //   ]);
  for(String a in pedidos){
    rows.add(
    DataRow(cells:[
      DataCell(Text('26/04/2021')),
      DataCell(Text('desa')),
      DataCell(Text(a)),
      DataCell(Text('botones xd'))
    ])

    );
  }
  return rows;
}
