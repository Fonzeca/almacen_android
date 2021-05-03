part of 'bloc_almacen_bloc.dart';

class AlmacenState extends Equatable{
  final List<Pedido> pedidos;
  final bool carga;

  AlmacenState([this.carga, this.pedidos]);

  @override
  List<Object> get props => [pedidos,carga];

  AlmacenState copyWith(
      {bool carga, List<Pedido> pedidos}) {
    return AlmacenState(carga ?? this.carga, pedidos ?? this.pedidos);
  }
}

