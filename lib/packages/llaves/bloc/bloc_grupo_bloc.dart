import 'dart:async';

import 'package:almacen_android/packages/llaves/data/api_calls.dart';
import 'package:almacen_android/packages/llaves/model/grupoLlaves.dart';
import 'package:almacen_android/packages/llaves/model/llave.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_grupo_event.dart';
part 'bloc_grupo_state.dart';

class GrupoBloc extends Bloc<GrupoEvent, GrupoState> {
  GrupoBloc() : super(GrupoState());
  ServidorLlaves _servidor = ServidorLlaves();

  @override
  Stream<GrupoState> mapEventToState(
    GrupoEvent event,
  ) async* {
    if(event is GrupoEventSetGrupo){
      yield state.copyWith(carga: true);
      GrupoEventSetGrupo _setGrupo = event as GrupoEventSetGrupo;
      String identificacionGrupoLlaves = _setGrupo.nombre+"-"+_setGrupo.id;
      GrupoLlave grupo = await _servidor.getGrupoLlave(identificacionGrupoLlaves);
      yield state.copyWith(carga: false,grupoLlave: grupo);
    }else if(event is GrupoEventCambiarEstado){
      //gl
    }else if(event is GrupoEventSetLlave){
      yield state.copyWith(carga: true);
      Llave llave = await _servidor.getLlaveEspecifica(event.id);
      yield state.copyWith(llave: llave,carga: false);
    }
  }
}
