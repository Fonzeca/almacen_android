import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:almacen_android/packages/almacen/model/pojo/articulo_nvopedido.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_almacen_nuevoPedido_event.dart';
part 'bloc_almacen_nuevoPedido_state.dart';


class NuevoPedidoBloc extends Bloc<NuevoPedidoEvent,NuevoPedidoState>{
  NuevoPedidoBloc() : super (NuevoPedidoState());
  Servidor _servidor = Servidor();

  @override
  Stream<NuevoPedidoState> mapEventToState(
      NuevoPedidoEvent event,
      ) async*{
    if (event is NuevoPedidoEventClear){
      state.articulosAPedir.clear();
      state.observaciones="";
    }
    if (event is NuevoPedidoEventAddArt){
      NuevoPedidoEventAddArt eventAddArt = event as NuevoPedidoEventAddArt;
      Artxcant artxcant = new Artxcant(eventAddArt.nombreArt,eventAddArt.cantidad);
      state.articulosAPedir.add(artxcant);
    }
    if(event is NuevoPedidoEventDeleteArt){
      NuevoPedidoEventDeleteArt eventDeleteArt= event as NuevoPedidoEventDeleteArt;
      for(int i = 0; i<state.articulosAPedir.length;i++){
        if(state.articulosAPedir[i].nombreArt == eventDeleteArt.nombreArt){
          state.articulosAPedir.removeAt(i);
        }
      }
    }
    if (event is NuevoPedidoEventSavePedido){
//TODO: Terminar cuando el back sepa que va a recibir un array xD
      await _servidor.crearPedido(state.observaciones, state.nombreUsuario, state.articulosAPedir);

    }
    if (event is NuevoPedidoEventSetUser){
      NuevoPedidoEventSetUser eventSetUser = event as NuevoPedidoEventSetUser;
      state.nombreUsuario= eventSetUser.username;
    }
  }
}