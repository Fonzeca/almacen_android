part of 'bloc_almacen_agregar_stock_bloc.dart';

abstract class AlmacenAgregarStockEvent extends Equatable{
  const AlmacenAgregarStockEvent();
  @override
  List<Object> get props => [];
}

class AgregarStockEventInitialize extends AlmacenAgregarStockEvent{

}

class AgregarStockEventBuscarArticulo extends AlmacenAgregarStockEvent{
  String identficacion;
  AgregarStockEventBuscarArticulo(this.identficacion);
}

class AgregarStockEventReconocerQr extends AlmacenAgregarStockEvent{
  String resultado;
  AgregarStockEventReconocerQr(this.resultado);
}

class AgregarStockEventAgregarStock extends AlmacenAgregarStockEvent{
  String nombre, cantidad;
  AgregarStockEventAgregarStock(this.nombre,this.cantidad);
}
