part of 'bloc_almacen_bloc.dart';

class AlmacenState extends Equatable{
  final List<Pedido> pedidos;
  final PedidoDetalleView detalleView;

  final bool carga;

  AlmacenState({this.carga, this.pedidos, this.detalleView});

  @override
  List<Object> get props => [pedidos, detalleView, carga];

  AlmacenState copyWith({bool carga, List<Pedido> pedidos, PedidoDetalleView detalleView}) {
    return AlmacenState(
      carga: carga ?? this.carga,
      pedidos: pedidos ?? this.pedidos,
      detalleView: detalleView ?? detalleView);
  }
}

