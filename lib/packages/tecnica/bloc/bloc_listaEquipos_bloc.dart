import 'package:almacen_android/packages/tecnica/data/api_calls.dart';
import 'package:almacen_android/packages/tecnica/model/equipo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_listaEquipos_state.dart';
part 'bloc_listaEquipos_event.dart';

class ListaEquiposBloc extends Bloc<ListaEquiposEvent, ListaEquiposState>{
  ListaEquiposBloc() : super(ListaEquiposState());
  ServidorTecnica _servidorTecnica= ServidorTecnica();

  @override
  Stream<ListaEquiposState> mapEventToState(ListaEquiposEvent event,) async*{
    if(event is ListaEquiposEventListarEquipos){
      List<Equipo> equipos = [];
      yield state.copyWith(carga: true);
        equipos = await _servidorTecnica.listarEquipos();

        yield state.copyWith(listaEquipos: equipos, carga: false);

    }else if(event is ListaEquiposEventGetDetalle){
      ListaEquiposEventGetDetalle eventGetDetalle = event as ListaEquiposEventGetDetalle;
      yield state.copyWith(carga: true);

      Equipo equipo;
      equipo = await _servidorTecnica.getDetalleEquipo(eventGetDetalle.id);
      yield state.copyWith(equipo: equipo, carga: false);
    }else if(event is ListaEquipoEventEliminarEquipo){

      ListaEquipoEventEliminarEquipo eliminarEquipo = event as ListaEquipoEventEliminarEquipo;
      yield state.copyWith(carga: true);

      await _servidorTecnica.eliminarEquipo(eliminarEquipo.id);
      List<Equipo> equipos = state.listaEquipos;
      equipos.removeWhere((element) => element.id == eliminarEquipo.id);

      yield state.copyWith(listaEquipos: equipos, carga: false);
    }else if(event is ListaEquipoEventCambiarEstadoEquipo){

      ListaEquipoEventCambiarEstadoEquipo cambiarEstadoEquipo = event as ListaEquipoEventCambiarEstadoEquipo;
      yield state.copyWith(carga: true);

      await _servidorTecnica.cambiarEstadoEquipo(cambiarEstadoEquipo.id);
      List<Equipo> equipos = await _servidorTecnica.listarEquipos();

      yield state.copyWith(listaEquipos: equipos, carga: false);
    }
  }
}