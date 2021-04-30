import 'package:equatable/equatable.dart';

class Token extends Equatable{
  final String token;
  final String expireAt;
  final String id;


  Token.fromJson(Map<String, dynamic> json):
        token= json['token'],
        expireAt= json['expireAt'],
        id=json['id'];

  @override
  List<Object> get props => [token,expireAt,id];
}
