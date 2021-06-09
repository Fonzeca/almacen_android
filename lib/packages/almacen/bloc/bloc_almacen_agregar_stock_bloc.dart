import 'dart:async';

import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

part 'bloc_almacen_agregar_stock_event.dart';
part 'bloc_almacen_agregar_stock_state.dart';

class AgregarStockBloc extends Bloc<AlmacenAgregarStockEvent, AlmacenAgregarStockState> {
  AgregarStockBloc() : super(AlmacenAgregarStockState());
  Servidor _servidor = Servidor();

  @override
  Stream<AlmacenAgregarStockState> mapEventToState(
    AlmacenAgregarStockEvent event,
  ) async* {
    if(event is AgregarStockEventInitialize){

      yield state.copyWith(carga: true,qrArticulo: null,articulo: null);
    }else if (event is AgregarStockEventReconocerQr){
      AgregarStockEventReconocerQr reconocerQr = event as AgregarStockEventReconocerQr;

      yield state.copyWith(qrArticulo: reconocerQr.resultado,carga: false);

    }else if (event is AgregarStockEventBuscarArticulo){
      AgregarStockEventBuscarArticulo buscarArticulo = event as AgregarStockEventBuscarArticulo;

      yield state.copyWith(carga: true);
      Articulo articulo= await _servidor.getArticuloFromQr(buscarArticulo.identficacion);

      yield state.copyWith(articulo: articulo ,carga: false);
    }else if (event is AgregarStockEventAgregarStock){
      AgregarStockEventAgregarStock agregarStock = event as AgregarStockEventAgregarStock;

      yield state.copyWith(carga: true);
      Articulo articulo = await _servidor.agregarStockToArticulo(agregarStock.nombre, agregarStock.cantidad);

      yield state.copyWith(articulo: articulo,carga: false, success: true);
    }
  }
}
