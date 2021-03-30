import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:equatable/equatable.dart';

class Articulo extends Equatable{
  final String nombre;
  final String estado,stockMinimo, subcategoria;
  final int stock;
  final Proveedor proveedor;
  final String costo;
  final String qr;

  Articulo (this.nombre, this.estado,
      this.proveedor,this.subcategoria,
      this.costo,this.stock,this.stockMinimo,
      this.qr);

  Articulo.fromJson(Map<String, dynamic> json):
      //TODO: tanto estado como subcategoria vuelven nulos desde el json xq no se mapean los objetos Subcategoria y EstadoArticulo. Tratar como String?
        nombre= json['nombre'],
        estado= "",
        proveedor= json['proveedor'],
        subcategoria= "",
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