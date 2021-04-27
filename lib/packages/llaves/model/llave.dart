import 'package:almacen_android/packages/tecnica/model/lugar.dart';
import 'package:equatable/equatable.dart';

class Llave extends Equatable{

  final String copia, identificacion, nombre, observaciones,estado;
  final Lugar ubicacion;


  Llave(this.copia, this.identificacion, this.nombre, this.observaciones, this.estado, this.ubicacion);
  Llave.fromJson(Map<String, dynamic> json):
        copia=json['copia'],
        identificacion=json['identificacion'],
        nombre=json['nombre'],
        observaciones=json['observaciones'],
        estado=json['estado'],
        ubicacion=Lugar("test", "esto esta hardcore");


  @override
  List<Object> get props => [identificacion,nombre,copia,ubicacion,estado,observaciones];

}