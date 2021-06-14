import 'package:equatable/equatable.dart';

import 'llave.dart';

class GrupoLlave extends Equatable{
  final int grupoId;
  final String nombre, estado;
  final List<Llave> llaves;

  GrupoLlave(this.grupoId,this.nombre, this.estado, this.llaves);

  GrupoLlave.fromJson(Map<String, dynamic> json):
      grupoId = json["grupoId"],
      nombre = json["nombre"],
      estado = json["estado"],
      llaves = List.from(json["llaves"]).map((e) => Llave.fromJson(e)).toList();


  @override
  List<Object> get props => [grupoId, nombre, estado, llaves];
}