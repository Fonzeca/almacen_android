part of 'bloc_almacen_agregar_stock_bloc.dart';

class AlmacenAgregarStockState extends Equatable{
  final Articulo articulo;
  final String qrArticulo;
  final bool carga;

  AlmacenAgregarStockState([this.articulo, this.qrArticulo, this.carga]);

  @override
  List<Object> get props =>[articulo, qrArticulo, carga];

  AlmacenAgregarStockState copyWith({bool carga, String qrArticulo, Articulo articulo}){
    return AlmacenAgregarStockState(
      articulo ?? this.articulo,
      qrArticulo ?? this.qrArticulo,
      carga ?? this.carga,
    );
  }
}

