part of 'bloc_listaEquipos_bloc.dart';

class ListaEquiposState extends Equatable{
  final List<Equipo> listaEquipos;
  final Equipo equipo;

  ListaEquiposState([this.listaEquipos,this.equipo]);

  @override
  List<Object> get props => [listaEquipos,equipo];

  ListaEquiposState copyWith({List<Equipo> listaEquipos, Equipo equipo}){
    return ListaEquiposState(
      listaEquipos ?? this.listaEquipos,
      equipo ?? this.equipo,
    );
  }
}