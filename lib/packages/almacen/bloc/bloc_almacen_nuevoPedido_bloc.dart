import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:almacen_android/packages/almacen/model/pojo/articulo_nvopedido.dart';
import 'package:almacen_android/packages/almacen/model/pojo/loggedUser.dart';
import 'package:almacen_android/packages/common/common_api_calls.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_almacen_nuevoPedido_event.dart';
part 'bloc_almacen_nuevoPedido_state.dart';


class NuevoPedidoBloc extends Bloc<NuevoPedidoEvent, NuevoPedidoState>{
  NuevoPedidoBloc() : super (NuevoPedidoState());
  Servidor _servidor = Servidor();
  CommonApiCalls _apiCalls = CommonApiCalls();

  @override
  Stream<NuevoPedidoState> mapEventToState(NuevoPedidoEvent event) async*{
    if (event is NuevoPedidoEventClear){
      yield* onEventClear(event);
    }else if (event is NuevoPedidoEventAddArt){
      yield* onEventAddArt(event);
    }else if(event is NuevoPedidoEventDeleteArt){
      yield* onEventDeleteArt(event);
    }else if (event is NuevoPedidoEventSavePedido){
      yield* onEventSavePedido(event);
    }else if (event is NuevoPedidoEventSetUser){
      yield* onEventSetUser(event);
    }else if(event is NuevoPedidoInitialize){
      yield* onEventInitialize(event);
    }
  }

  Stream<NuevoPedidoState> onEventClear(NuevoPedidoEventClear event) async*{
    yield state.copyWith(observaciones: "");
  }

  Stream<NuevoPedidoState> onEventAddArt(NuevoPedidoEventAddArt event) async*{
    NuevoPedidoEventAddArt eventAddArt = event;

    Artxcant artxcant = new Artxcant(eventAddArt.nombreArt, eventAddArt.cantidad);
    List<Artxcant> nuevaLista = state.articulosAPedir;
    bool cambio=false;
    if(nuevaLista == null){
      nuevaLista = [];
    }
    for(Artxcant a in nuevaLista){
      if(cambio){
        break;
      }
      //TODO: no está funcionando correctamente, cuando se aprieta el '+' se cambia la cantidad internamente pero no se muestra y ese numero queda en el campo cantidad.
      print("articulo "+a.nombreArt);
      if(a.nombreArt==artxcant.nombreArt){
        int i,j;
        i= int.parse(a.cantidad);
        j= int.parse(artxcant.cantidad);

        Artxcant newArt = Artxcant (a.nombreArt,(i+j).toString());
        nuevaLista.remove(a);
        nuevaLista.add(newArt);
        print("Cantidad editada");
        cambio=true;
      }
    }
    if(!cambio){
      print("sumado Art");
      nuevaLista.add(artxcant);
    }
    print("Se envia la lista");
    yield state.copyWith(articulosAPedir: nuevaLista);
  }

  Stream<NuevoPedidoState> onEventDeleteArt(NuevoPedidoEventDeleteArt event) async*{
    NuevoPedidoEventDeleteArt eventDeleteArt= event;
    List<Artxcant> artsApedir= state.articulosAPedir;
    for(int i = 0; i< artsApedir.length; i++){
      if(artsApedir[i].nombreArt == eventDeleteArt.nombreArt){
        artsApedir.removeAt(i);
      }
    }
    yield state.copyWith(articulosAPedir: artsApedir);
  }

  Stream<NuevoPedidoState> onEventSavePedido(NuevoPedidoEventSavePedido event) async*{
    await _servidor.crearPedido(state.observaciones, state.nombreUsuario, state.articulosAPedir);
    yield state;
  }

  Stream<NuevoPedidoState> onEventSetUser(NuevoPedidoEventSetUser event) async*{
    NuevoPedidoEventSetUser eventSetUser = event;

    yield state.copyWith(nombreUsuario: eventSetUser.username);
  }

  Stream<NuevoPedidoState> onEventInitialize(NuevoPedidoInitialize event) async*{
    NuevoPedidoInitialize nuevoPedidoInitialize=event as NuevoPedidoInitialize;
    if(nuevoPedidoInitialize.adm){
      List<String> lstusuarios = await _servidor.listarUsuarios();
      List<Articulo> articulos =  await _servidor.listarArticulos();
      //TODO: que pasa si la lista esta vacia o null?
      LoggedUser userActual = await _apiCalls.getLoggedUser();
      yield state.copyWith(listaUsuarios: lstusuarios, nombreUsuario: userActual.nombreUsuario, listaArticulos: articulos);

    }else{
      List<Articulo> articulos =  await _servidor.listarArticulos();
      //TODO: Agregar tanto acá como arriba el usuario actual.
      yield state.copyWith(listaArticulos: articulos);

    }
  }

}