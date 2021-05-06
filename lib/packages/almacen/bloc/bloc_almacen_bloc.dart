import 'dart:async';

import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/pedido.dart';
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
      pedidos = await _servidor.listarPedidos();
      yield state.copyWith(pedidos: pedidos, carga: false);
    }
    if(event is AlmacenEventInitialize){
      yield state.copyWith(carga: true);

    }
  }
}
