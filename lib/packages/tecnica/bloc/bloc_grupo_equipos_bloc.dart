import 'dart:async';

import 'package:almacen_android/packages/tecnica/data/api_calls.dart';
import 'package:almacen_android/packages/tecnica/model/equipo.dart';
import 'package:almacen_android/packages/tecnica/model/grupoEquipo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_grupo_equipos_event.dart';
part 'bloc_grupo_equipos_state.dart';

class GrupoEquiposBloc extends Bloc<GrupoEquiposEvent, GrupoEquiposState> {
  GrupoEquiposBloc() : super(GrupoEquiposState());
  ServidorTecnica _servidorTecnica= ServidorTecnica();

  @override
  Stream<GrupoEquiposState> mapEventToState(
    GrupoEquiposEvent event,
  ) async* {
    if(event is GrupoEquiposEventSetGrupo){
      yield* onEventSetGrupo(event);
    }else if(event is GrupoEquiposEventSetEquipo){
      yield* onEventSetEquipo(event);
    }else if(event is GrupoEquiposEventChangeStatus){
      yield* onEventChangeStatus(event);
    }
  }

  Stream<GrupoEquiposState> onEventSetGrupo(GrupoEquiposEventSetGrupo event) async*{
    yield state.copyWith(carga: true);

    String identificacion = event.nombre + "-" + event.id;

    GrupoEquipo grupo = await _servidorTecnica.getGrupoEquipoByQr(identificacion);

    yield state.copyWith(grupo: grupo,carga: false);
  }

  Stream<GrupoEquiposState> onEventSetEquipo(GrupoEquiposEventSetEquipo event) async*{
    yield state.copyWith(carga: true);

    Equipo equipo = await _servidorTecnica.getDetalleEquipo(event.id);

    yield state.copyWith(equipo: equipo, carga: false);
  }

  /// Evento cuando se cambia el estado de un Grupo
  Stream<GrupoEquiposState> onEventChangeStatus(GrupoEquiposEventChangeStatus event) async*{
    yield state.copyWith(carga: true);

    String id, entrada, nombre;
    id = state.grupo.grupoId.toString();
    nombre = state.grupo.nombre;
    entrada = event.entrada;

    await _servidorTecnica.cambiarEstadoGrupoEquipo(id, entrada);

    String identificacion = nombre + "-" + id;

    GrupoEquipo grupo = await _servidorTecnica.getGrupoEquipoByQr(identificacion);

    yield state.copyWith(grupo: grupo,carga: false);
  }


}
