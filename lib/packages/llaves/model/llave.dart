import 'package:equatable/equatable.dart';

class Llave extends Equatable{

  final String id, copia, grupo, nombre, observaciones,estado, ubicacion;


  Llave(this.id, this.copia, this.grupo, this.nombre, this.observaciones, this.estado, this.ubicacion);
  Llave.fromJson(Map<String, dynamic> json):
      id=json['id'],
        nombre=json['nombre'],
        copia=json['copia'],
        grupo=json['grupo'],
        estado=json['estado'],
        observaciones=json['observaciones'],
        ubicacion=json['ubicacion'];


  @override
  List<Object> get props => [grupo,nombre,copia,ubicacion,estado,observaciones];

}