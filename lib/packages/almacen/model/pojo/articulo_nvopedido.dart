import 'package:equatable/equatable.dart';

class Artxcant extends Equatable{
  final String nombreArt, cantidad;
  Artxcant(this.nombreArt,this.cantidad);

  @override
  List<Object> get props => [nombreArt, cantidad];
}