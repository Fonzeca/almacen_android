part of 'bloc_grupo_bloc.dart';

abstract class GrupoEvent extends Equatable {
  const GrupoEvent();
  @override
  List<Object> get props => [];
}

class GrupoEventCambiarEstado extends GrupoEvent{

}
class GrupoEventSetGrupo extends GrupoEvent{
  String nombre, id;
  GrupoEventSetGrupo(this.id,this.nombre);
}

class GrupoEventSetLlave extends GrupoEvent{
  String id;
  GrupoEventSetLlave(this.id);
}