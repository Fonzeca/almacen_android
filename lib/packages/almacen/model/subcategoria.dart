import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:equatable/equatable.dart';

class Subcategoria extends Equatable{

  final String nombre;

  Subcategoria(this.nombre);

  Subcategoria.fromJson(Map<String, dynamic> json):
    nombre=json['subNombre'];

  @override
  List<Object> get props => [nombre];
}