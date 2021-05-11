import 'package:almacen_android/packages/llaves/data/api_calls.dart';
import 'package:almacen_android/packages/llaves/model/llave.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_llaves_scanLlave_event.dart';
part 'bloc_llaves_scanLlave_state.dart';


class ScannearLlaveBloc extends Bloc<ScannearLlaveEvent, ScannearLlaveState>{
  ScannearLlaveBloc() : super(ScannearLlaveState());
  ServidorLlaves _servidor = ServidorLlaves();

  @override
  Stream<ScannearLlaveState> mapEventToState(ScannearLlaveEvent event,)async*{
    if(event is ScannearLlaveEventInitialize){
      print("entro a inicializar"+state.qrDetectado.toString());
      yield state.copyWith(carga: true,qrDetectado: "");
    }else if(event is ScannearLlaveCambiarQr){
      ScannearLlaveCambiarQr eventCambiarQr = event as ScannearLlaveCambiarQr;

      yield state.copyWith(carga:false,qrDetectado: eventCambiarQr.nuevoQr);
    }else if(event is ScannearLlaveBuscarLlave){
      ScannearLlaveBuscarLlave buscarLlave = event as ScannearLlaveBuscarLlave;
      String identificacion = buscarLlave.id;

      Llave llave = await _servidor.getLlaveEspecifica(identificacion);

      yield state.copyWith(llave: llave);
    }else if(event is ScannearLlaveCambiarEstado){

      yield state.copyWith(carga: true);
      ScannearLlaveCambiarEstado cambiarEstado = event as ScannearLlaveCambiarEstado;
      await _servidor.changeLlaveEstado(cambiarEstado.identificacion, cambiarEstado.estado);
      Llave llave = await _servidor.getLlaveEspecifica(cambiarEstado.identificacion);
      yield state.copyWith(carga: false,llave: llave);
    }
  }

}