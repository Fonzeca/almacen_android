import 'package:equatable/equatable.dart';
import 'modelTecnica.dart';

class Tipo extends Equatable{
  final String nombre;
  List<Equipo> equipos;

  Tipo(this.nombre,this.equipos);
  Tipo.fromJson(Map<String, dynamic> json):
      nombre=json['nombre'],
      equipos=json['equipos'];

  @override
  List<Object> get props => [nombre,equipos];
}