part of 'bloc_almacen_bloc.dart';

abstract class AlmacenState extends Equatable {
  const AlmacenState();
}

class AlmacenInitial extends AlmacenState {
  @override
  List<Object> get props => [];
}
