import 'package:equatable/equatable.dart';

class LoggedUser extends Equatable{
  final String nombre;
  final String apellido;
  final String nombreUsuario;
  final String email;
  final bool esAdmin;
  final String rol;

  LoggedUser(this.nombre, this.apellido, this.nombreUsuario, this.email, this.esAdmin, this.rol);

  LoggedUser.fromJson(Map<String, dynamic> json):
        nombre = json['nombre'],
        apellido = json['apellido'],
        nombreUsuario = json['nombreUsuario'],
        esAdmin = json['esAdmin'],
        rol = json['rol'],
        email = json['email'];

  List<Object> get props => [nombre, apellido, nombreUsuario, email, esAdmin, rol];
}