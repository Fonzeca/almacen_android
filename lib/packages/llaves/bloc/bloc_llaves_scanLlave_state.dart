part of 'bloc_llaves_scanLlave_bloc.dart';

class ScannearLlaveState extends Equatable{
final bool carga;
final String qrDetectado;
final Llave llave;

  ScannearLlaveState([this.carga, this.qrDetectado, this.llave]);
  @override
  List<Object> get props => [carga, qrDetectado, llave];

  ScannearLlaveState copyWith({bool carga, String qrDetectado, Llave llave}){
    return ScannearLlaveState(
      carga ?? this.carga,
      qrDetectado ?? this.qrDetectado,
      llave ?? this.llave,
    );
  }

}