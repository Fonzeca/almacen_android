import 'package:equatable/equatable.dart';

class Artxcant extends Equatable{
  final String nombreArt;
  final String cantidad;
  Artxcant(this.nombreArt,this.cantidad);

  @override
  List<Object> get props => [nombreArt, cantidad];
}