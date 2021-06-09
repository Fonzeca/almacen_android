part of 'bloc_almacen_agregar_stock_bloc.dart';

class AlmacenAgregarStockState extends Equatable{
  final Articulo articulo;
  final String qrArticulo;
  final bool carga;
  final bool success;

  AlmacenAgregarStockState({this.articulo, this.qrArticulo, this.carga, this.success});

  @override
  List<Object> get props =>[articulo, qrArticulo, carga];

  AlmacenAgregarStockState copyWith({bool carga, String qrArticulo, Articulo articulo, bool success}){
    return AlmacenAgregarStockState(
      articulo: articulo ?? this.articulo,
      qrArticulo: qrArticulo ?? this.qrArticulo,
      carga: carga ?? this.carga,
      success: success ?? false
    );
  }
}

