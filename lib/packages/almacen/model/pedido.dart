import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:equatable/equatable.dart';

class Pedido extends Equatable{

  final EstadoPedido estadoPedido;
  final String //TODO: Usuario
  usuario;
  final String fecha;
  final String observaciones;
  List<ArticulosPedido> articulosPedidos;

  Pedido(this.usuario,this.estadoPedido,this.articulosPedidos,this.observaciones, this.fecha);

  Pedido.fromJson(Map<String, dynamic> json):
      estadoPedido=json['estadopedido'],
  usuario=json['usuario'],
  fecha=json['fecha'],
  observaciones=json['observaciones'],
  articulosPedidos=json['articulosPPedido'];

  @override
  List<Object> get props => [fecha, estadoPedido,usuario,articulosPedidos,observaciones];
}

class EstadoPedido extends Equatable{
  final String nombreEstado;
  List<Pedido> pedidos;

  EstadoPedido(this.nombreEstado,this.pedidos);

  EstadoPedido.fromJson(Map<String, dynamic> json):
      nombreEstado=json['nombreEstado'],
  pedidos=json['pedidos'];

  @override
  // TODO: implement props
  List<Object> get props => [nombreEstado];
}

class ArticulosPedido extends Equatable{
  final Articulo articulo;
  final Pedido pedido;
  final int cantidad;

  ArticulosPedido(this.pedido,this.articulo,this.cantidad);

  ArticulosPedido.fromJson(Map<String, dynamic> json):
    articulo=json['articulo'],
    pedido = json['pedido'],
    cantidad = json['cantidad'];

  @override
  List<Object> get props => [pedido
  ,articulo,cantidad];
}