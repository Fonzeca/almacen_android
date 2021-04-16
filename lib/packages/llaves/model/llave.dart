import 'package:almacen_android/packages/tecnica/model/lugar.dart';
import 'package:equatable/equatable.dart';

class Llave extends Equatable{

  final String copia, identificacion, nombre, observaciones,estado,descripcion;
  final Lugar ubicacion;


  Llave(this.identificacion,this.nombre,this.copia, this.descripcion,this.observaciones,this.ubicacion, this.estado);
  Llave.fromJson(Map<String, dynamic> json):
      identificacion=json['identificacion'],
  nombre=json['nombre'],
  copia=json['copia'],
  descripcion=json['descripcion'],
  observaciones=json['observaciones'],
  ubicacion=json['ubicacion'],
  estado=json['estado'];


  @override
  List<Object> get props => [identificacion,nombre,copia,descripcion,ubicacion,estado,observaciones];

}