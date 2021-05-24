part of 'bloc_almacen_bloc.dart';

class AlmacenState extends Equatable{
  final List<Pedido> pedidos;
  final PedidoDetalleView detalleView;
  final bool entregado;

  final List<Pedido> pedidosFiltrados;
  final PedidoFiltro filtro;

  final bool carga;

  AlmacenState({this.carga, this.pedidos, this.detalleView, this.entregado, this.pedidosFiltrados, this.filtro});

  @override
  List<Object> get props => [pedidos, detalleView, carga, entregado, pedidosFiltrados, filtro];

  AlmacenState copyWith({bool carga, List<Pedido> pedidos, PedidoDetalleView detalleView, bool entregado, List<Pedido> pedidosFiltrados, PedidoFiltro filtro}) {
    return AlmacenState(
      carga: carga ?? this.carga,
      pedidos: pedidos ?? this.pedidos,
      detalleView: detalleView ?? detalleView,
      entregado: entregado ?? true,
      pedidosFiltrados : pedidosFiltrados ?? this.pedidosFiltrados,
      filtro : filtro ?? this.filtro,
    );
  }
}

