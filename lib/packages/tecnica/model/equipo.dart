import 'package:equatable/equatable.dart';

class Equipo extends Equatable {
  final String nombre, tipo,serial, modelo, observaciones, usuario, accesorios, lugar;
  final bool enUso;

  Equipo(this.usuario, this.observaciones, this.nombre, this.tipo, this.enUso, this.lugar, this.accesorios, this.modelo, this.serial);

  Equipo.fromJson(Map<String, dynamic> json):
      tipo= json['tipo'],
        usuario = json['usuario'],
        nombre = json['nombre'],
        serial = json['serial'],
        modelo = json['modelo'],
        observaciones = json['observaciones'],
        accesorios = json['accesorios'],
  lugar = json['lugar'],
        enUso = json['enUso'];

  @override
  List<Object> get props => [nombre, modelo, serial, usuario, lugar, tipo, enUso, accesorios, observaciones];
}