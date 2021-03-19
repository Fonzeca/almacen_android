import 'package:almacen_android/packages/almacen/model/modelAlmacen.dart';
import 'package:equatable/equatable.dart';

class Proveedor extends Equatable{
    final String provNombre, provTel, provContacto, provDireccion, provMail;
    List<Articulo> articulos;

    Proveedor(this.provNombre,this.provTel,this.provDireccion,this.provContacto,this.provMail,this.articulos);

    Proveedor.fromJson(Map<String, dynamic> json):
        provNombre=json['provNombre'],
        provTel=json['provTel'],
        provContacto=json['provContacto'],
        provMail=json['provMail'],
        provDireccion=json['provDireccion'],
        articulos=json['articulos'];
    @override
  // TODO: implement props
  List<Object> get props => [provNombre,provTel,provDireccion,provContacto,provMail,articulos];
    }