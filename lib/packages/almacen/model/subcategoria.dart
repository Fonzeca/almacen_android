import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:equatable/equatable.dart';

class Subcategoria extends Equatable{

  final String nombre;
  final Categoria categoria;
  List<Articulo> articulos;

  Subcategoria(this.nombre,this.categoria,this.articulos);

  Subcategoria.fromJson(Map<String, dynamic> json):
    nombre=json['subNombre'],
    categoria=json['categoria'],
    articulos=json['articulos'];

  @override
  List<Object> get props => [nombre,categoria,articulos];
}