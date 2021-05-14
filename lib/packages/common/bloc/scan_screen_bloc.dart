import 'dart:async';

import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/llaves/data/api_calls.dart';
import 'package:almacen_android/packages/tecnica/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:almacen_android/packages/llaves/model/modelLlaves.dart';
import 'package:almacen_android/packages/tecnica/model/modelTecnica.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scan_screen_event.dart';
part 'scan_screen_state.dart';

class ScanScreenBloc extends Bloc<ScanScreenEvent, ScanScreenState> {
  ScanScreenBloc() : super(ScanScreenState());

  Servidor _servidorAlmacen = Servidor();
  ServidorLlaves _servidorLlaves = ServidorLlaves();
  ServidorTecnica _servidorTecnica = ServidorTecnica();

  @override
  Stream<ScanScreenState> mapEventToState(
      ScanScreenEvent event,
      ) async* {
    if(event is ScanEventGetGrupoLlave){

      ScanEventGetGrupoLlave getGrupoLlave = event as ScanEventGetGrupoLlave;
      yield state.copyWith(carga: true);

      GrupoLlave grupoLlave = await _servidorLlaves.getGrupoLlave(splitString(getGrupoLlave.identificacionGrupoLlaves));
      yield state.copyWith(grupoLlave:grupoLlave, carga: false);

    }else if (event is ScanEventGetGrupoEquipo){

      ScanEventGetGrupoEquipo getGrupoEquipo = event as ScanEventGetGrupoEquipo;
      yield state.copyWith(carga: true);

      GrupoEquipo grupoEquipo = await _servidorTecnica.getGrupoEquipoByQr(splitString(getGrupoEquipo.identificacionGrupoEquipo));
      yield state.copyWith(grupoEquipo: grupoEquipo, carga: false);

    }else if(event is ScanEventGetEquipo){

      ScanEventGetEquipo getEquipo = event as ScanEventGetEquipo;
      yield state.copyWith(carga: true);

      Equipo equipo = await _servidorTecnica.getDetalleEquipo(splitString(getEquipo.identificacionEquipo).split("-").last);
      yield state.copyWith(equipo: equipo,carga: false);

    }else if(event is ScanEventGetArticulo){

      ScanEventGetArticulo getArticulo = event as ScanEventGetArticulo;
      yield state.copyWith(carga: true);

      Articulo articulo = await _servidorAlmacen.getArticuloFromQr(splitString(getArticulo.identificacionArticulo));
      yield state.copyWith(articulo: articulo,carga: false);
    }
  }

  String splitString (String identificacion){
    List <String> qr = identificacion.split("-");
    return qr[1]+"-"+qr[2];
  }
}
