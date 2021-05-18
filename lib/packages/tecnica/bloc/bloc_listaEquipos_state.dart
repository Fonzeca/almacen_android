part of 'bloc_listaEquipos_bloc.dart';

class ListaEquiposState extends Equatable{
  final List<Equipo> listaEquipos;
  final Equipo equipo;
  final bool carga;

  ListaEquiposState({this.carga, this.listaEquipos,this.equipo});

  @override
  List<Object> get props => [listaEquipos, equipo, carga];

  ListaEquiposState copyWith({bool carga, List<Equipo> listaEquipos, Equipo equipo}){
    return ListaEquiposState(
      carga: carga ?? this.carga,
      listaEquipos: listaEquipos ?? this.listaEquipos,
      equipo: equipo ?? equipo,
    );
  }
}