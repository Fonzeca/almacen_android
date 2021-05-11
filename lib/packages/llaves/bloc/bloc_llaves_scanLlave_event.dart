part of 'bloc_llaves_scanLlave_bloc.dart';

abstract class ScannearLlaveEvent extends Equatable{
  const ScannearLlaveEvent();
  @override
  List<Object> get props => [];

}

class ScannearLlaveEventInitialize extends ScannearLlaveEvent{

}
class ScannearLlaveCambiarQr extends ScannearLlaveEvent{
  final String nuevoQr;
  ScannearLlaveCambiarQr (this.nuevoQr);
}
class ScannearLlaveBuscarLlave extends ScannearLlaveEvent{
  String id;
  ScannearLlaveBuscarLlave(this.id,);
}
class ScannearLlaveCambiarEstado extends ScannearLlaveEvent{
  String identificacion,estado;
  ScannearLlaveCambiarEstado(this.identificacion,this.estado);
}
