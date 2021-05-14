import 'package:equatable/equatable.dart';

import 'llave.dart';

class GrupoLlave extends Equatable{
  final String nombre, estado;
  final List<Llave> llaves;

  GrupoLlave(this.nombre, this.estado, this.llaves);

  GrupoLlave.fromJson(Map<String, dynamic> json):
      nombre = json["nombre"],
      estado = json["estado"],
      llaves = json["llaves"];


  @override
  List<Object> get props => [nombre, estado, llaves];
}