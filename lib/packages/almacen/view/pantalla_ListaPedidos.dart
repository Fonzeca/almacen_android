import 'package:almacen_android/packages/almacen/bloc/bloc_almacen_bloc.dart';
import 'package:almacen_android/packages/almacen/model/pedido.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListaPedidos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AlmacenBloc>(context).add(AlmacenEventInitialize());
    return BlocListener<AlmacenBloc,AlmacenState>(
      listener: (context, state) {
        switch(state.carga){
          case true:
            EasyLoading.show();
            break;
          case false:
            EasyLoading.dismiss();
            break;
        }
      },
      child: BlocBuilder<AlmacenBloc,AlmacenState>(
        builder: (context, state) {
          if (state.pedidos ==null){
            BlocProvider.of<AlmacenBloc>(context).add(AlmacenEventBuscarPedidos());

            return Container();
          }else
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
                  ], rows: _createRow(state.pedidos))

                ]);
        },
      ),
    );
  }

}
List<DataRow> _createRow (List<Pedido>pedidos){
  List<DataRow> rows= new List<DataRow>();
  for(Pedido p in pedidos){

    rows.add(DataRow(cells: [

      DataCell(Text(p.fecha)),
      DataCell(Text(p.usuario)),
      DataCell(Text(p.estadoPedido)),
      DataCell(Text('botones xd'))
    ]));
  }
  return rows;
}
