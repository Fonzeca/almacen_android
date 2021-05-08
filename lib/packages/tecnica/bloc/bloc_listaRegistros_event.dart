part of 'bloc_listaRegistros_bloc.dart';

abstract class ListaRegistrosEvent extends Equatable {
  const ListaRegistrosEvent();

  @override
  List<Object> get props => [];

}
class ListaRegistrosEventListarRegistros extends ListaRegistrosEvent{

}