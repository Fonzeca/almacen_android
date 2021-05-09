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
      equipos = await _servidorTecnica.listarEquipos();
      yield state.copyWith(listaEquipos: equipos);
    }else if(event is ListaEquiposEventGetDetalle){
      ListaEquiposEventGetDetalle eventGetDetalle = event as ListaEquiposEventGetDetalle;
      Equipo equipo;
      equipo = await _servidorTecnica.getDetalleEquipo(eventGetDetalle.id);
      yield state.copyWith(equipo: equipo);
    }
  }
}