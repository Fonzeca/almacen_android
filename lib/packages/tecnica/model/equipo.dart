import 'package:equatable/equatable.dart';
import 'modelTecnica.dart';

class Equipo extends Equatable {
  final Lugar lugar;
  final Tipo tipo;
  final String nombre, serial, modelo, observaciones,usuario,
  accesorios, estado;
  List<Registro> registros;

  Equipo(this.usuario,this.observaciones,this.nombre,this.estado,this.accesorios,this.lugar,this.modelo,this.registros,this.serial,this.tipo);

  Equipo.fromJson(Map<String, dynamic> json):
  lugar=json['lugar'],
  tipo=json['tipo'],
  usuario=json['usuario.getNombreUsuario'],
  nombre=json['nombre'],
  serial=json['serial'],
  modelo=json['modelo'],
  observaciones=json['observaciones'],
  accesorios=json['accesorios'],
  estado=json['estado'],
  registros=json['registros'];

  @override
  List<Object> get props => [nombre, modelo, tipo,serial,
  lugar,usuario,estado,accesorios,observaciones,registros];
}