import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:equatable/equatable.dart';

class Articulo extends Equatable{
  final String nombre;
  final EstadoArticulo estado;
  final Proveedor proveedor;
  final Subcategoria subcategoria;
  final double costo;
  final int stockMinimo;
  final int stock;
  final String qr;

Articulo (this.nombre, this.estado,
    this.proveedor,this.subcategoria,
    this.costo,this.stock,this.stockMinimo,
    this.qr);

Articulo.fromJson(Map<String, dynamic> json):
  nombre= json['nombre'],
  estado= json['estadoarticulo'],
  proveedor= json['proveedor'],
  subcategoria= json['subcategoria'],
  costo=json['costo'],
  stockMinimo=json['stockMinimo'],
  stock=json['stock'],
  qr=json['codigoQr'];

@override
  List<Object> get props => [nombre,subcategoria,costo,estado,stock,stockMinimo,proveedor,qr];

}

class EstadoArticulo extends Equatable{
  final String nombreEstado;
  List<Articulo> articulos;

  EstadoArticulo(this.nombreEstado,this.articulos);
  EstadoArticulo.fromJson(Map<String, dynamic> json):
      nombreEstado=json['nombreEstado'],
  articulos=json['articulos'];

  @override
  List<Object> get props => [nombreEstado];

}