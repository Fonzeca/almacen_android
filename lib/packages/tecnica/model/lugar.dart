import 'package:equatable/equatable.dart';

class Lugar extends Equatable{

  final String nombre, descripcion;

  Lugar(this.nombre,this.descripcion);
  Lugar.fromJson(Map<String, dynamic> json):
      nombre=json['nombre'],
  descripcion=json['descripcion'];

  @override
  // TODO: implement props
  List<Object> get props => [nombre, descripcion];
}