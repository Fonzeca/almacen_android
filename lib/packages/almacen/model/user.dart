import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String token;
  final String nombre;
  final String username;
  final String area;
  final String rol;
  final String jsessionid;


  User.fromJson(Map<String, dynamic> json):
        token= json['token'],
        nombre= json['nombre'],
        username=json['username'],
        area=json['area'],
        rol=json['rol'],
        jsessionid=json['jsessionid'];

  @override
  List<Object> get props => [token,nombre,username,area,rol,jsessionid];
}
