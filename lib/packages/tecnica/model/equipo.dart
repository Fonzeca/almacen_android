import 'package:equatable/equatable.dart';
import 'modelTecnica.dart';

class Equipo extends Equatable {
  final String nombre, serial, modelo, observaciones, usuario, accesorios;
  final bool enUso;

  Equipo(this.usuario, this.observaciones, this.nombre, this.enUso, this.accesorios, this.modelo, this.serial);

  Equipo.fromJson(Map<String, dynamic> json):
        usuario = json['usuario'],
        nombre = json['nombre'],
        serial = json['serial'],
        modelo = json['modelo'],
        observaciones = json['observaciones'],
        accesorios = json['accesorios'],
        enUso = json['enUso'];

  @override
  List<Object> get props => [nombre, modelo, serial, usuario, enUso, accesorios, observaciones];
}