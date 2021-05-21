import 'package:almacen_android/packages/almacen/bloc/bloc_almacen_bloc.dart';
import 'package:almacen_android/packages/almacen/model/pedido.dart';
import 'package:almacen_android/packages/almacen/model/pojo/almacenPojos.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListaPedidos extends StatelessWidget{
  bool admn;

  ListaPedidos ({Key key, @required this.admn}):super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AlmacenBloc>(context).add(AlmacenEventBuscarPedidos());
    return BlocListener<AlmacenBloc,AlmacenState>(
      listener: (context, state) {
        if (state.carga){
          EasyLoading.show();
        }else{
          EasyLoading.dismiss();
        }
        if(state.detalleView != null){
          crearModal(context,state.detalleView);
        }
        if(!state.entregado){
          EasyLoading.showToast("Pedido en espera por falta de stock.");
        }
      },
      child:
      BlocBuilder<AlmacenBloc,AlmacenState>(
        builder: (context, state) {
          if (state.pedidos == null){
            return Container();
          }else
            return
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.pedidos == null ? 1 : state.pedidos.length + 1,
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
  Color colorEstado = Colors.black;
  if(p.estadoPedido == "En Curso"){
    colorEstado = Colors.black;
  }else if(p.estadoPedido == "Entregado"){
    colorEstado = Colors.green;
  }else if(p.estadoPedido == "En Espera"){
    colorEstado = Colors.black;
  }

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
          color: index.isEven ? Colors.white : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: adm ?
              [
                Text(p.fecha),
                Text(p.usuario),
                Text(p.estadoPedido, style: TextStyle(color: colorEstado),),
              ]:
              [
                Text(p.fecha),
                Text(p.estadoPedido, style: TextStyle(color: colorEstado),),
              ],

            ),
          ),
        )),
  );



}

void crearModal(BuildContext context, PedidoDetalleView detalle) {
  EasyLoading.dismiss();
  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Pedido Número ' +
                    detalle.pedidoId.toString()),
                SizedBox(height: 5.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Usuario: ' + detalle.usuario),
                    SizedBox(width: 20.0,),
                    Text('Estado: ' + detalle.estadopedido),
                  ],
                ),
                Divider(color: Colors.deepOrangeAccent,thickness: 1.0,),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: detalle.articulosPedidos.length,
                        itemBuilder: (context, index) {
                          ArticuloPedidoView articuloView = detalle.articulosPedidos[index];
                          bool red = false;
                          if(detalle.articulosFaltantes !=null && detalle.articulosFaltantes!=[]){
                            for(String a in detalle.articulosFaltantes){
                              if(a == articuloView.nombre){
                                red = true;
                              }
                            }
                          }
                          return Container(
                            color: (index % 2 == 0) ? Colors.white : Colors.black12,
                            child: ListTile(
                              title: red? Text(articuloView.nombre,style: TextStyle(color: Colors.red),):Text(articuloView.nombre),
                              trailing: Text(articuloView.cantidad.toString()),
                              dense: true,
                            ),
                          );
                        }),
                  ),
                ),
                Divider(color: Colors.deepOrangeAccent,thickness: 1.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Observaciones: "),
                    Flexible(
                      child: AutoSizeText(
                        detalle.observaciones ?? "",
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.deepOrangeAccent,thickness: 1.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    detalle.estadopedido.contains("Entregado")  ?
                    SizedBox(width: 0,):
                    ElevatedButton.icon(onPressed: ()=> _entregarPedido(context, detalle.pedidoId.toString()),
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
      }
  );
}





void _entregarPedido (BuildContext context, String id) {
  BlocProvider.of<AlmacenBloc>(context).add(AlmacenEventEntregarPedido(id));
  Navigator.pop(context);
  EasyLoading.showToast("Pedido número "+id+" entregado.");
}
void _eliminarPedido (BuildContext context, String id){
  BlocProvider.of<AlmacenBloc>(context).add(AlmacenEventEliminarPedido(id));
  EasyLoading.showToast("Se eliminó el pedido número "+id);
}