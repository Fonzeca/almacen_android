import 'package:equatable/equatable.dart';

class PedidoDetalleView extends Equatable{
 int pedidoId;
 String estadopedido, usuario, observaciones;
 List<dynamic> articulosPedidos;

PedidoDetalleView(this.pedidoId,this.usuario,this.observaciones,this.estadopedido);

  @override
  List<Object> get props => [this.pedidoId,this.usuario,this.observaciones,this.estadopedido];

  PedidoDetalleView.fromJson(Map<String, dynamic> json):
      pedidoId= json['pedidoId'],
      estadopedido= json['estadopedido'],
      usuario= json['usuario'],
      observaciones= json['observaciones'],
 articulosPedidos= json['pedidos'];

}
class ArticuloPedidoView extends Equatable{
  int cantidad, articuloId;
  String nombre;

  ArticuloPedidoView(this.cantidad,this.nombre,this.articuloId);

  @override
  List<Object> get props => [this.articuloId,this.nombre,this.cantidad];
}