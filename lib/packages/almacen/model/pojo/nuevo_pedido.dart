import 'package:equatable/equatable.dart';

class NuevoPedido extends Equatable{
  final String observaciones;
  final String nombreUsuario;
  final String nombresArticulos;
  final String cantidadesArticulos;

  NuevoPedido(this.observaciones, this.nombreUsuario, this.nombresArticulos, this.cantidadesArticulos);

  NuevoPedido.fromJson(Map<String, dynamic> json):
        observaciones = json['observaciones'],
        nombreUsuario = json['nombreUsuario'],
        nombresArticulos = json['nombresArticulos'],
        cantidadesArticulos = json['cantidadesArticulos'];

  Map<String, dynamic> toJson() => {
    'observaciones': observaciones,
    'nombreUsuario': nombreUsuario,
    'nombresArticulos': nombresArticulos,
    'cantidadesArticulos': cantidadesArticulos,
  };

  @override
  List<Object> get props => [observaciones, nombreUsuario, nombresArticulos, cantidadesArticulos];
}