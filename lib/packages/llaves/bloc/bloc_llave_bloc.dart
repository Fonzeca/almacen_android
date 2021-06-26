import 'package:almacen_android/packages/llaves/data/api_calls.dart';
import 'package:almacen_android/packages/llaves/model/modelLlaves.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_llave_event.dart';
part 'bloc_llave_state.dart';


class LlaveBloc extends Bloc<LlaveEvent, LlaveState>{
  LlaveBloc() : super(LlaveState());
  ServidorLlaves _servidor = ServidorLlaves();

  @override
  Stream<LlaveState> mapEventToState(LlaveEvent event,)async*{
    if(event is LlaveCambiarEstado){

      yield state.copyWith(carga: true);
      LlaveCambiarEstado cambiarEstado = event as LlaveCambiarEstado;
      await _servidor.changeLlaveEstado(cambiarEstado.identificacion, cambiarEstado.estado,cambiarEstado.username);
      Llave llave = await _servidor.getLlaveEspecifica(cambiarEstado.identificacion);
      yield state.copyWith(carga: false,llave: llave);
    }else if(event is LlaveCargarLlave){

      yield state.copyWith(carga: true);
      LlaveCargarLlave cargarLlave = event as LlaveCargarLlave;
      Llave llave = await _servidor.getLlaveEspecifica(cargarLlave.id);
      yield state.copyWith(llave: llave,carga: false);
    }
  }

}