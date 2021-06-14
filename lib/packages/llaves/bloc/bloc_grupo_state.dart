part of 'bloc_grupo_bloc.dart';

class GrupoState extends Equatable {
  final bool carga;
  final GrupoLlave grupoLlave;
  final Llave llave;

  GrupoState({this.carga, this.grupoLlave, this.llave});

  @override
  List<Object> get props => [carga, grupoLlave, llave];

  GrupoState copyWith({bool carga, GrupoLlave grupoLlave, Llave llave}){
    return GrupoState(
      carga: carga ?? this.carga,
      grupoLlave: grupoLlave ?? this.grupoLlave,
      llave: llave ?? llave,
    );
  }
}

