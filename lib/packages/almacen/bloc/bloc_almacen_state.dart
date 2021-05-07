part of 'bloc_almacen_bloc.dart';

class AlmacenState extends Equatable{
  final List<Pedido> pedidos;
  final bool carga;
  final PedidoDetalleView detalleView;

  AlmacenState([this.carga, this.pedidos, this.detalleView]);

  @override
  List<Object> get props => [pedidos,carga, detalleView];

  AlmacenState copyWith(
      {bool carga, List<Pedido> pedidos, PedidoDetalleView detalleView}) {
    return AlmacenState(carga ?? this.carga, pedidos ?? this.pedidos,
    detalleView ?? this.detalleView);
  }
}

