part of 'bloc_grupo_bloc.dart';

abstract class GrupoEvent extends Equatable {
  const GrupoEvent();
  @override
  List<Object> get props => [];
}

class GrupoEventCambiarEstado extends GrupoEvent{

}
class GrupoEventSetGrupo extends GrupoEvent{
  GrupoLlave grupoLlave;
  GrupoEventSetGrupo(this.grupoLlave);
}