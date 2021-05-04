import 'dart:js';

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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.pedidos==null? 1 : state.pedidos.length + 1,
                  itemBuilder: (context, index) {
                    if(index==0){
                      return Row(
                        children: [
                          Text("Fecha",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Usuario",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Estado",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      );
                    }
                    index -=1;
                    return _createRow(state.pedidos[index],context);
                  },)
              ],
            );
        },
      ),
    );
  }

}
Widget _createRow (Pedido p,BuildContext context){

  return GestureDetector(
    onTap: (){
      EasyLoading.showToast("Este es el detalle del pedido, y entregar?");
    },
    child: Dismissible(

        key: Key(p.toString()),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Atención!"),
                content: const Text("¿Eliminar el pedido?"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Eliminar")
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancelar"),
                  ),
                ],
              );
            },
          );
        },

        onDismissed: (DismissDirection direction){
          _eliminarPedido(context,p.id);
        },background: Container(color: Colors.red,),
        child: Row(
          children: [
            Text(p.fecha),
            Text(p.usuario),
            Text(p.estadoPedido),
          ],

        )),
  );
}

void _entregarPedido (String id) {
  EasyLoading.showToast("Pedido número "+id+" entregado.");
}
Future<void> _eliminarPedido (BuildContext context, String id){
  EasyLoading.showToast("Se eliminó el pedido número "+id+", kappa");
}