part of 'bloc_almacen_nuevoPedido_bloc.dart';

class NuevoPedidoState extends Equatable{
  List<Artxcant> articulosAPedir;
  String nombreUsuario, observaciones;

  List<Articulo> listaArticulos;
  List<String> listaUsuarios;

  NuevoPedidoState([String nombreUsuario, List<Artxcant> articulosAPedir, String observaciones, List<String> listaUsuarios, List<Articulo> listaArticulos]);

  @override
  List<Object> get props => [articulosAPedir, nombreUsuario, observaciones, listaArticulos, listaUsuarios];

  NuevoPedidoState copyWith({String nombreUsuario, List<Artxcant> articulosAPedir, String observaciones, List<String> listaUsuarios, List<Articulo> listaArticulos}){
    return NuevoPedidoState(
        nombreUsuario?? this.nombreUsuario,
        articulosAPedir??this.articulosAPedir,
        observaciones?? this.observaciones,
        listaUsuarios ?? this.listaUsuarios,
        listaArticulos ?? this.listaArticulos);
  }
}
