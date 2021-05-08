part of 'bloc_listaRegistros_bloc.dart';

class ListaRegistrosState extends Equatable{
  final List<Registro> registros;

  ListaRegistrosState([this.registros]);

  @override
  List<Object> get props => [registros,];

  ListaRegistrosState copyWith({List<Registro> registros,}){
    return ListaRegistrosState(
      registros ?? this.registros,
    );
  }
}