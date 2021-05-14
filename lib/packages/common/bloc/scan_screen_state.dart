part of 'scan_screen_bloc.dart';

class ScanScreenState extends Equatable{
  final bool carga;
  final GrupoLlave grupoLlave;
  final GrupoEquipo grupoEquipo;
  final Equipo equipo;
  final Articulo articulo;

  ScanScreenState([this.carga,this.articulo,this.grupoEquipo,this.grupoLlave,this.equipo]);

  @override
  List<Object> get props => [carga,articulo,equipo,grupoLlave,grupoEquipo];

  ScanScreenState copyWith({bool carga, Articulo articulo, Equipo equipo, GrupoLlave grupoLlave, GrupoEquipo grupoEquipo}){
    return ScanScreenState(
      carga ?? this.carga,
      articulo ?? this.articulo,
      grupoEquipo ?? this.grupoEquipo,
      grupoLlave ?? this.grupoLlave,
      equipo ?? this.equipo

    );
  }
}

