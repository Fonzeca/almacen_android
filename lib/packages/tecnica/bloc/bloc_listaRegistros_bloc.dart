import 'package:almacen_android/packages/tecnica/data/api_calls.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almacen_android/packages/tecnica/model/modelTecnica.dart';

part 'bloc_listaRegistros_event.dart';
part 'bloc_listaRegistros_state.dart';

class ListaRegistrosBloc extends Bloc<ListaRegistrosEvent, ListaRegistrosState>{
  ListaRegistrosBloc() : super (ListaRegistrosState());
  ServidorTecnica _servidor = ServidorTecnica();

  @override
  Stream<ListaRegistrosState> mapEventToState(ListaRegistrosEvent event,) async*{
    if(event is ListaRegistrosEventListarRegistros){
      List<Registro> registros = await _servidor.listarRegistros();
      
      yield state.copyWith(registros: registros);
    }
  }
}