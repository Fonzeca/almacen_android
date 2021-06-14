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
      yield state.copyWith(carga: true);
      GrupoEquiposEventSetGrupo _setGrupo = event as GrupoEquiposEventSetGrupo;
      String identificacion = _setGrupo.nombre+"-"+_setGrupo.id;
      GrupoEquipo grupo = await _servidorTecnica.getGrupoEquipoByQr(identificacion);
      yield state.copyWith(grupo: grupo,carga: false);

    }else if(event is GrupoEquiposEventSetEquipo){
      yield state.copyWith(carga: true);
      Equipo equipo;
      equipo = await _servidorTecnica.getDetalleEquipo(event.id);
      yield state.copyWith(equipo: equipo, carga: false);
    }
  }
}
