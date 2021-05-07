part of 'bloc_listaEquipos_bloc.dart';

class ListaEquiposState extends Equatable{
  final List<Equipo> listaEquipos;

  ListaEquiposState([this.listaEquipos]);

  @override
  List<Object> get props => [listaEquipos];

  ListaEquiposState copyWith({List<Equipo> listaEquipos}){
    return ListaEquiposState(
      listaEquipos ?? this.listaEquipos,
    );
  }
}