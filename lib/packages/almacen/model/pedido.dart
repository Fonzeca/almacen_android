import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:equatable/equatable.dart';

class Pedido extends Equatable{

  final EstadoPedido estadoPedido;
  final String //TODO: Usuario
  usuario;
  final String fecha;
  final String observaciones;

  Pedido(this.usuario,this.estadoPedido,this.observaciones, this.fecha);

  Pedido.fromJson(Map<String, dynamic> json):
        estadoPedido=json['estadopedido'],
        usuario=json['usuario'],
        fecha=json['fecha'],
        observaciones=json['observaciones'];

  @override
  List<Object> get props => [fecha, estadoPedido,usuario,observaciones];
}

class EstadoPedido extends Equatable{
  final String nombreEstado;

  EstadoPedido(this.nombreEstado);

  EstadoPedido.fromJson(Map<String, dynamic> json):
        nombreEstado=json['nombreEstado'];

  @override
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