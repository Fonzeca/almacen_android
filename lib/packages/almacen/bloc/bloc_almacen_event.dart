part of 'bloc_almacen_bloc.dart';

abstract class AlmacenEvent extends Equatable {
  const AlmacenEvent();
  @override
  List<Object> get props => [];
}

class AlmacenEventBuscarPedidos extends AlmacenEvent{
}

class AlmacenEventInitialize extends AlmacenEvent{
}

class AlmacenEventGetDetalle extends AlmacenEvent{
  String id;
  AlmacenEventGetDetalle(this.id);
}

class AlmacenEventEntregarPedido extends AlmacenEvent{
  String id;
  AlmacenEventEntregarPedido(this.id);
}

class AlmacenEventEliminarPedido extends AlmacenEvent{
  String id;
  AlmacenEventEliminarPedido(this.id);
}
