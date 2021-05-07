import 'package:almacen_android/packages/almacen/bloc/bloc_almacen_bloc.dart';
import 'package:almacen_android/packages/almacen/model/pedido.dart';
import 'package:almacen_android/packages/almacen/model/pojo/almacenPojos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListaPedidos extends StatelessWidget{
  bool admn;

  ListaPedidos ({Key key, @required this.admn}):super(key: key);

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
        if(state.detalleView!=null){
          crearModal(context,state.detalleView);
        }
      },
      child:
      BlocBuilder<AlmacenBloc,AlmacenState>(
        builder: (context, state) {
          if (state.pedidos ==null){
            BlocProvider.of<AlmacenBloc>(context).add(AlmacenEventBuscarPedidos());
            return Container();
          }else
            return
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.pedidos==null ? 1 : state.pedidos.length + 1,
                itemBuilder: (context, index) {
                  if(admn){
                    if(index==0){
                      return Card(
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                              [
                                Text("Fecha",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                                Text("Usuario",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold)),
                                Text("Estado",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                      );
                    }
                    index -=1;
                    return _createRow(state.pedidos[index],context,index,admn);
                  }else{
                    if(index==0){
                      return Card(
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                              [
                                Text("Fecha",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold)),
                                Text("Estado",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                      );
                    }
                    index -=1;
                    return _createRow(state.pedidos[index],context,index,admn);
                  }
                },
              )
            ;
        },
      ),
    );
  }

}
Widget _createRow (Pedido p,BuildContext context,int index,bool adm){
  return GestureDetector(
    onTap: (){
      EasyLoading.show();
      BlocProvider.of<AlmacenBloc>(context).add(AlmacenEventGetDetalle(p.id));


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
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Eliminar")
                  ),
                  TextButton(
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
        child: Card(
          color: index.isEven ? Colors.white : Colors.black12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: adm ?
              [
                Text(p.fecha),
                Text(p.usuario),
                Text(p.estadoPedido),
              ]:
              [
                Text(p.fecha),
                Text(p.estadoPedido),
              ],

            ),
          ),
        )),
  );



}
void crearModal(BuildContext context, PedidoDetalleView detalle) {
  PedidoDetalleView detalleView = detalle;
  EasyLoading.dismiss();
  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(height: 200,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Pedido Número ' +
                    detalleView.pedidoId.toString()),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Usuario: ' + detalleView.usuario),
                    SizedBox(width: 20.0,),
                    Text('Estado: ' + detalleView.estadopedido),
                  ],
                ),
                Divider(color: Colors.deepOrangeAccent,thickness: 1.0,),
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: detalleView.articulosPedidos.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(
                          detalleView.articulosPedidos[index].cantidad
                              .toString() + " " +
                              detalleView.articulosPedidos[index]
                                  .nombre),);
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(onPressed: ()=> _entregarPedido(context, detalleView.pedidoId.toString()),
                      label: const Text('Entregar'), icon: const Icon(Icons.check_circle_outline_sharp),
                      style: ElevatedButton.styleFrom(primary: Colors.green),),
                    SizedBox(width: 40.0,),
                    ElevatedButton(
                      child: const Text('Cerrar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
          ),);
      });
}





void _entregarPedido (BuildContext context, String id) {
  EasyLoading.showToast("Pedido número "+id+" entregado.");
  //TODO: llamar api entregar y eliminar respectivamente.
  Navigator.pop(context);
}
void _eliminarPedido (BuildContext context, String id){
  EasyLoading.showToast("Se eliminó el pedido número "+id+", kappa");
}