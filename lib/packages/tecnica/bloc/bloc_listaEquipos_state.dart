part of 'bloc_listaEquipos_bloc.dart';

class ListaEquiposState extends Equatable{
  final List<Equipo> listaEquipos;
  final List<Equipo> equiposPropios;
  final Equipo equipo;
  final bool carga;

  ListaEquiposState({this.carga, this.listaEquipos,this.equipo, this.equiposPropios});

  @override
  List<Object> get props => [listaEquipos, equipo, carga, equiposPropios];

  ListaEquiposState copyWith({bool carga, List<Equipo> listaEquipos, Equipo equipo, List<Equipo> equiposPropios}){
    return ListaEquiposState(
      carga: carga ?? this.carga,
      listaEquipos: listaEquipos ?? this.listaEquipos,
      equipo: equipo ?? equipo,
      equiposPropios: equiposPropios ?? equiposPropios,
    );
  }
}