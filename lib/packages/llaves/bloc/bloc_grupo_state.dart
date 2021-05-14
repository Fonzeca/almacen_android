part of 'bloc_grupo_bloc.dart';

class GrupoState extends Equatable {
  final bool carga;
  final GrupoLlave grupoLlave;

  GrupoState([this.carga, this.grupoLlave]);

  @override
  List<Object> get props => [carga, grupoLlave];

  GrupoState copyWith({bool carga, GrupoLlave grupoLlave}){
    return GrupoState(
      carga ?? this.carga,
      grupoLlave ?? this.grupoLlave,
    );
  }
}

