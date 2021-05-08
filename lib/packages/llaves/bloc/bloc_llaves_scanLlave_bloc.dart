import 'package:almacen_android/packages/llaves/data/api_calls.dart';
import 'package:almacen_android/packages/llaves/model/llave.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_llaves_scanLlave_event.dart';
part 'bloc_llaves_scanLlave_state.dart';


class ScannearLlaveBloc extends Bloc<ScannearLlaveEvent, ScannearLlaveState>{
  ScannearLlaveBloc() : super(ScannearLlaveState());
  ServidorLlaves _servidor = ServidorLlaves();

  @override
  Stream<ScannearLlaveState> mapEventToState(ScannearLlaveEvent event,)async*{
    if(event is ScannearLlaveEventInitialize){
      yield state.copyWith(carga: true,qrDetectado: "");
    }
    
    
    if(event is ScannearLlaveCambiarQr){
      ScannearLlaveCambiarQr eventCambiarQr = event as ScannearLlaveCambiarQr;

      yield state.copyWith(carga:false,qrDetectado: eventCambiarQr.nuevoQr);
    }

    if(event is ScannearLlaveBuscarLlave){
      ScannearLlaveBuscarLlave buscarLlave = event as ScannearLlaveBuscarLlave;
      Llave llave = await _servidor.getLlaveEspecifica(buscarLlave.id);

      yield state.copyWith(llave: llave);
    }
  }

}