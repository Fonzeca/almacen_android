import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_almacen_event.dart';
part 'bloc_almacen_state.dart';

class AlmacenBloc extends Bloc<AlmacenEvent, AlmacenState> {
  AlmacenBloc() : super(AlmacenInitial());

  @override
  Stream<AlmacenState> mapEventToState(
    AlmacenEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
