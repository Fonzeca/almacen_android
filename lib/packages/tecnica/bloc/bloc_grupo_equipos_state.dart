part of 'bloc_grupo_equipos_bloc.dart';

class GrupoEquiposState extends Equatable {
  final bool carga;
  final GrupoEquipo grupo;
  final Equipo equipo;

  GrupoEquiposState({this.carga, this.grupo, this.equipo});

  @override
  List<Object> get props => [carga, grupo, equipo];

  GrupoEquiposState copyWith({bool carga, GrupoEquipo grupo, Equipo equipo}){
    return GrupoEquiposState(
      carga : carga ?? this.carga,
      grupo : grupo ?? this.grupo,
      equipo : equipo ?? equipo,
    );
  }
}
