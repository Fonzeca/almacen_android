part of 'bloc_listaEquipos_bloc.dart';

abstract class ListaEquiposEvent extends Equatable{
  const ListaEquiposEvent();

  @override
  List<Object> get props => [];
}

class ListaEquiposEventListarEquipos extends ListaEquiposEvent{
}

class ListaEquiposEventGetDetalle extends ListaEquiposEvent{
  String id;
  ListaEquiposEventGetDetalle(this.id);
}

class ListaEquipoEventEliminarEquipo extends ListaEquiposEvent{
  String id;
  ListaEquipoEventEliminarEquipo(this.id);
}

class ListaEquipoEventCambiarEstadoEquipo extends ListaEquiposEvent{
  int id;
  ListaEquipoEventCambiarEstadoEquipo(this.id);
}

class ListaEquipoEventListarPropios extends ListaEquiposEvent{

}
class ListaEquipoEventLimpiarPropios extends ListaEquiposEvent{

}
