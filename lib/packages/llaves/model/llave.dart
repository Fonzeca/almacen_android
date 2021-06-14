import 'package:equatable/equatable.dart';

class Llave extends Equatable{

  final String id, copia, grupo, nombre, observaciones,estado, ubicacion, usuario;


  Llave(this.id, this.copia, this.grupo, this.nombre, this.observaciones, this.estado, this.ubicacion, this.usuario);
  Llave.fromJson(Map<String, dynamic> json):
      id=json['llaveId'].toString(),
        nombre=json['nombre'],
        copia=json['copia'],
        grupo=json['grupo'],
        estado=json['estado'],
        observaciones=json['observaciones']??"",
        ubicacion=json['ubicacion'],
        usuario=json['usuario'];


  @override
  List<Object> get props => [grupo,nombre,copia,ubicacion,estado,observaciones, usuario];

}
