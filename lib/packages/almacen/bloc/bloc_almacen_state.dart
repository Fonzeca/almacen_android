part of 'bloc_almacen_bloc.dart';

class AlmacenState extends Equatable{
  @override
  List<Pedido> pedidos;
  bool carga;

  AlmacenState([bool carga, List<Pedido> pedidos]);
  List<Object> get props => [pedidos,carga];

  AlmacenState copyWith(
      {bool carga, List<Pedido> pedidos}) {
    return AlmacenState(carga ?? this.carga, pedidos ?? this.pedidos);
  }
}