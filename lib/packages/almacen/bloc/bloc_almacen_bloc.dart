import 'dart:async';

import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/pedido.dart';
import 'package:almacen_android/packages/almacen/model/pojo/almacenPojos.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
    }


  }
}
