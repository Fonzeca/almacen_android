part of 'bloc_grupo_equipos_bloc.dart';

abstract class GrupoEquiposEvent extends Equatable {
  const GrupoEquiposEvent();
  @override
  List<Object> get props => [];
}

class GrupoEquiposEventSetGrupo extends GrupoEquiposEvent{
  String nombre;
  String id;
  GrupoEquiposEventSetGrupo(this.nombre, this.id);
}
class GrupoEquiposEventSetEquipo extends GrupoEquiposEvent{
  String id;
  GrupoEquiposEventSetEquipo(this.id);
}
class GrupoEquiposEventChangeStatus extends GrupoEquiposEvent{
  String entrada;
  GrupoEquiposEventChangeStatus(this.entrada);
}
