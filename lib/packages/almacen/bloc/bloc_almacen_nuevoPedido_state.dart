part of 'bloc_almacen_nuevoPedido_bloc.dart';


class NuevoPedidoState extends Equatable{
  final List<Artxcant> articulosAPedir;
  final int tamanioListaArticulosAPedir;
  final String nombreUsuario;

  final List<Articulo> listaArticulos;
  final List<String> listaUsuarios;

  NuevoPedidoState([this.nombreUsuario, this.articulosAPedir, this.listaUsuarios, this.listaArticulos, this.tamanioListaArticulosAPedir]);

  @override
  List<Object> get props => [articulosAPedir, nombreUsuario, listaArticulos, listaUsuarios, tamanioListaArticulosAPedir];

  NuevoPedidoState copyWith({String nombreUsuario, List<Artxcant> articulosAPedir, String observaciones, List<String> listaUsuarios, List<Articulo> listaArticulos}){
    return NuevoPedidoState(
        nombreUsuario ?? this.nombreUsuario,
        articulosAPedir ?? this.articulosAPedir,
        listaUsuarios ?? this.listaUsuarios,
        listaArticulos ?? this.listaArticulos,
        articulosAPedir?.length ?? this.tamanioListaArticulosAPedir);
  }
}
