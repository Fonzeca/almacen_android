part of 'bloc_grupo_bloc.dart';

class GrupoState extends Equatable {
  final bool carga;
  final GrupoLlave grupoLlave;
  final Llave llave;
  final List<String> usuarios;

  GrupoState({this.carga, this.grupoLlave, this.llave, this.usuarios});

  @override
  List<Object> get props => [carga, grupoLlave, llave, usuarios];

  GrupoState copyWith({bool carga, GrupoLlave grupoLlave, Llave llave, List<String> usuarios}){
    return GrupoState(
      carga: carga ?? this.carga,
      grupoLlave: grupoLlave ?? this.grupoLlave,
      llave: llave ?? llave,
      usuarios: usuarios ?? this.usuarios,
    );
  }
}

