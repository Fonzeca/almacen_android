part of 'bloc_listaEquipos_bloc.dart';

abstract class ListaEquiposEvent extends Equatable{
  const ListaEquiposEvent();

  @override
  List<Object> get props => [];
}

class ListaEquiposEventListarEquipos extends ListaEquiposEvent{

}