import 'dart:async';

import 'package:almacen_android/packages/llaves/model/grupoLlaves.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_grupo_event.dart';
part 'bloc_grupo_state.dart';

class GrupoBloc extends Bloc<GrupoEvent, GrupoState> {
  GrupoBloc() : super(GrupoState());

  @override
  Stream<GrupoState> mapEventToState(
    GrupoEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
