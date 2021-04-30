part of 'bloc_almacen_nuevoPedido_bloc.dart';


class NuevoPedidoState extends Equatable{
  final List<Artxcant> articulosAPedir;
  final int tamanioListaArticulosAPedir;
  final String nombreUsuario, observaciones;

  final List<Articulo> listaArticulos;
  final List<String> listaUsuarios;

  NuevoPedidoState([this.nombreUsuario, this.articulosAPedir, this.observaciones, this.listaUsuarios, this.listaArticulos, this.tamanioListaArticulosAPedir]);

  @override
  List<Object> get props => [articulosAPedir, nombreUsuario, observaciones, listaArticulos, listaUsuarios, tamanioListaArticulosAPedir];

  NuevoPedidoState copyWith({String nombreUsuario, List<Artxcant> articulosAPedir, String observaciones, List<String> listaUsuarios, List<Articulo> listaArticulos}){
    return NuevoPedidoState(
        nombreUsuario ?? this.nombreUsuario,
        articulosAPedir ?? this.articulosAPedir,
        observaciones ?? this.observaciones,
        listaUsuarios ?? this.listaUsuarios,
        listaArticulos ?? this.listaArticulos,
        articulosAPedir?.length ?? this.tamanioListaArticulosAPedir);
  }
}
