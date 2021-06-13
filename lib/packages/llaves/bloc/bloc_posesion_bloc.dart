import 'dart:async';

import 'package:almacen_android/packages/llaves/data/api_calls.dart';
import 'package:almacen_android/packages/llaves/model/llave.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_posesion_event.dart';
part 'bloc_posesion_state.dart';

class PosesionBloc extends Bloc<PosesionEvent, PosesionState> {
  PosesionBloc() : super(PosesionState());
  ServidorLlaves _servidorLlaves = ServidorLlaves();

  @override
  Stream<PosesionState> mapEventToState(
      PosesionEvent event,
  ) async* {
    if(event is PosesionEventCargarLista){
      yield state.copyWith(carga: true);
      List<Llave> llavesPosesion = await _servidorLlaves.getLlavesEnPosesion();
      yield state.copyWith(carga: false, llaves: llavesPosesion);

    }
  }
}
