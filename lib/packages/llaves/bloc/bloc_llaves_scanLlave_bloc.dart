import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_llaves_scanLlave_event.dart';
part 'bloc_llaves_scanLlave_state.dart';


class ScannearLlaveBloc extends Bloc<ScannearLlaveEvent, ScannearLlaveState>{
  ScannearLlaveBloc() : super(ScannearLlaveState());

  @override
  Stream<ScannearLlaveState> mapEventToState(ScannearLlaveEvent event,)async*{
    if(event is ScannearLlaveEventInitialize){
      yield state.copyWith(carga: true,qrDetectado: "");
    }
    if(event is ScannearLlaveCambiarQr){
      ScannearLlaveCambiarQr eventCambiarQr = event;

      yield state.copyWith(carga:false,qrDetectado: eventCambiarQr.nuevoQr);
    }

  }

}