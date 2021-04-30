import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:equatable/equatable.dart';

class Articulo extends Equatable{
  final String nombre;
  final String estado, subcategoria;
  final int stock;
  final String qr;

  Articulo (this.nombre, this.estado, this.subcategoria, this.stock, this.qr);

  Articulo.fromJson(Map<String, dynamic> json):
        nombre = json['nombre'],
        estado = json['estado'],
        subcategoria = json['subcategoria'],
        stock = json['stock'],
        qr = json['codigoQr'];

  @override
  List<Object> get props => [nombre, subcategoria, estado, stock, qr];
}

class EstadoArticulo extends Equatable{
  final String nombreEstado;
  List<Articulo> articulos;

  EstadoArticulo(this.nombreEstado,this.articulos);
  EstadoArticulo.fromJson(Map<String, dynamic> json):
        nombreEstado = json['nombreEstado'],
        articulos = json['articulos'];

  @override
  List<Object> get props => [nombreEstado];

}