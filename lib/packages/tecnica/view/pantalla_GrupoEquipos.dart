import 'package:almacen_android/packages/tecnica/model/grupoEquipo.dart';
import 'package:flutter/cupertino.dart';

class GrupoEquiposEspecifico extends StatelessWidget{
  GrupoEquipo grupoEquipo;
  GrupoEquiposEspecifico({Key key,@required this.grupoEquipo}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Pantalla destinada a un grupo de equipos"),
    );
  }

}