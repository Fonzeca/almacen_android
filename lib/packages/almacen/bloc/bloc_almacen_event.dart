part of 'bloc_almacen_bloc.dart';

abstract class AlmacenEvent extends Equatable {
  const AlmacenEvent();
}

class AlmacenEventBuscarPedidos extends AlmacenEvent{
  @override
  List<Object> get props => [];

}
