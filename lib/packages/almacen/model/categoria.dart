import 'package:equatable/equatable.dart';
import 'subcategoria.dart';


class Categoria extends Equatable{
  final String nombre;
  List<Subcategoria> subcategorias;

  Categoria (this.nombre, this.subcategorias);

  Categoria.fromJson(Map<String, dynamic> json):
      nombre= json['Nombre'],
      subcategorias= json['Subcategorias'];

  @override
  List<Object> get props => [nombre, subcategorias];
}