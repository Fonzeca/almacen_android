import 'package:equatable/equatable.dart';

class Equipo extends Equatable {
  final int id;
  final String nombre, tipo,serial, modelo, observaciones, usuario, accesorios, lugar;
  final bool enUso;

  Equipo(this.id, this.usuario, this.observaciones, this.nombre, this.tipo, this.enUso, this.lugar, this.accesorios, this.modelo, this.serial);
  Equipo copyWith({int id, String nombre, String serial, String modelo, String observaciones, String usuario, String accessorios, String lugar, bool enUso}){
    id ?? this.id;
    nombre ?? this.nombre;
    serial ?? this.serial;
    modelo ?? this.modelo;
    observaciones ?? this.observaciones;
    usuario ?? this.usuario;
    accesorios ?? this.accesorios;
    lugar ?? this.lugar;
    enUso ?? this.enUso;
  }
  Equipo.fromJson(Map<String, dynamic> json):
      id= json['id'],
        nombre = json['nombre'],
      tipo= json['tipo'],
        usuario = json['usuario'],
        enUso = json['enUso'],
        lugar = json['lugar'],
        serial = json['serial'],
        modelo = json['modelo'],
        accesorios = json['accesorios'],
        observaciones = json['observaciones'];

  @override
  List<Object> get props => [nombre, modelo, serial, usuario, lugar, tipo, enUso, accesorios, observaciones];
}