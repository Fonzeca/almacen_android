part of 'bloc_llaves_scanLlave_bloc.dart';

class ScannearLlaveState extends Equatable{
final bool carga;
final String qrDetectado;

  ScannearLlaveState([this.carga, this.qrDetectado]);
  @override
  List<Object> get props => [carga, qrDetectado];

  ScannearLlaveState copyWith({bool carga, String qrDetectado}){
    return ScannearLlaveState(
      carga ?? this.carga,
      qrDetectado ?? this.qrDetectado,
    );
  }

}