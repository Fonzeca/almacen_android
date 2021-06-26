part of 'bloc_llave_bloc.dart';

abstract class LlaveEvent extends Equatable{
  const LlaveEvent();
  @override
  List<Object> get props => [];

}

class LlaveCambiarEstado extends LlaveEvent{
  String identificacion,estado,username;
  LlaveCambiarEstado(this.identificacion,this.estado, this.username);
}
class LlaveCargarLlave extends LlaveEvent{
  String id;
  LlaveCargarLlave(this.id);
}
