part of 'bloc_posesion_bloc.dart';

class PosesionState extends Equatable {
  final bool carga;
  final List<Llave> llaves;


  PosesionState([this.carga, this.llaves]);

  @override
  List<Object> get props => [carga, llaves];

  PosesionState copyWith({bool carga, List<Llave> llaves}){
    return PosesionState(
      carga ?? this.carga,
      llaves ?? this.llaves,
    );
  }
}

