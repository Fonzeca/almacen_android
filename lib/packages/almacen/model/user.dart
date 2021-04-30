import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String nombre;
  final String username;
  final String apellido;


  User.fromJson(Map<String, dynamic> json):
        nombre = json['nombre'],
        username = json['nombreUsuario'],
        apellido = json['apellido'];

  @override
  List<Object> get props => [nombre,username,apellido];
}
