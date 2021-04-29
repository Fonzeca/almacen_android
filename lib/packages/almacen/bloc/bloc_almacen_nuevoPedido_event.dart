part of 'bloc_almacen_nuevoPedido_bloc.dart';

abstract class NuevoPedidoEvent extends Equatable{
  const NuevoPedidoEvent();
  @override
  List<Object> get props => [];
}

class NuevoPedidoEventClear extends NuevoPedidoEvent{
}
class NuevoPedidoEventGetArts extends NuevoPedidoEvent{

}

class NuevoPedidoEventAddArt extends NuevoPedidoEvent{
  final String nombreArt;
  final String cantidad;
  NuevoPedidoEventAddArt(this.nombreArt,this.cantidad);
}
class NuevoPedidoEventDeleteArt extends NuevoPedidoEvent{
  final String nombreArt;
  NuevoPedidoEventDeleteArt(this.nombreArt);
}

class NuevoPedidoEventSetUser extends NuevoPedidoEvent{
  final String username;
  NuevoPedidoEventSetUser(this.username);
}

class NuevoPedidoEventSavePedido extends NuevoPedidoEvent{
}