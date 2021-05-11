import 'dart:async';

import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/pedido.dart';
import 'package:almacen_android/packages/almacen/model/pojo/almacenPojos.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_almacen_event.dart';
part 'bloc_almacen_state.dart';

class AlmacenBloc extends Bloc<AlmacenEvent, AlmacenState> {
  AlmacenBloc() : super(AlmacenState());
  Servidor _servidor = Servidor();

  @override
  Stream<AlmacenState> mapEventToState(AlmacenEvent event,) async* {
    if(event is AlmacenEventBuscarPedidos){
      List<Pedido> pedidos = [];

      yield state.copyWith(carga: true);

      pedidos = await _servidor.listarPedidos();

      yield state.copyWith(pedidos: pedidos, carga: false);
    }else if(event is AlmacenEventGetDetalle){
      yield state.copyWith(carga: true);
      AlmacenEventGetDetalle getDetalle = event as AlmacenEventGetDetalle;
      int id = int.parse(getDetalle.id);

      print("Se busca el detalle con id"+id.toString());

      PedidoDetalleView detalleView = await _servidor.getDetallePedido(id);

      yield state.copyWith(detalleView: detalleView, carga: false);
    }else if(event is AlmacenEventEntregarPedido){
      yield state.copyWith(carga:true);
      AlmacenEventEntregarPedido entregarPedido = event as AlmacenEventEntregarPedido;

      await _servidor.entregarPedido(entregarPedido.id);
      List<Pedido> pedidos = await _servidor.listarPedidos();

      yield state.copyWith(carga:false,pedidos: pedidos);
    }else if(event is AlmacenEventEliminarPedido) {
      AlmacenEventEliminarPedido eliminarPedido = event as AlmacenEventEliminarPedido;

      yield state.copyWith(carga: true);

      await _servidor.eliminarPedido(eliminarPedido.id);
      List<Pedido> pedidos = state.pedidos;
      pedidos.removeWhere((element) => element.id == eliminarPedido.id);

      yield state.copyWith(carga:false,pedidos: pedidos);
    }


  }
}
