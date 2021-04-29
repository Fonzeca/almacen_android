part of 'bloc_almacen_nuevoPedido_bloc.dart';

class NuevoPedidoState extends Equatable{
  List<Artxcant> articulosAPedir;
  String nombreUsuario, observaciones;

  NuevoPedidoState([String nombreUsuario, List<Artxcant> articulosAPedir, String observaciones]);

  @override
  List<Object> get props => [articulosAPedir, nombreUsuario, observaciones];

  NuevoPedidoState copyWith(
  {String nombreUsuario, List<Articulo> articulos,
  List<String> cantidades, String observaciones}){
    return NuevoPedidoState(nombreUsuario?? this.nombreUsuario,
        articulosAPedir??this.articulosAPedir,
        observaciones?? this.observaciones);
  }
}
