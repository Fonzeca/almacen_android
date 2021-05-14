part of 'bloc_llave_bloc.dart';

class LlaveState extends Equatable{
final bool carga;
final Llave llave;

  LlaveState([this.carga, this.llave]);
  @override
  List<Object> get props => [carga, llave];

  LlaveState copyWith({bool carga, Llave llave}){
    return LlaveState(
      carga ?? this.carga,
      llave ?? this.llave,
    );
  }

}