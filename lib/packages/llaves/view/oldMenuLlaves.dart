import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuLlaves extends StatefulWidget{
  bool admin;
  MenuLlaves(this.admin);

  @override
  State<StatefulWidget> createState() {
    if (admin){
      return LlavesStateAdmin();
    }
    return LlavesState();
  }
}
class LlavesState extends State<MenuLlaves>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Llaves"),
      ),
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
              DrawerHeader(child: Text("Canal 12")),
              ListTile(
                title: Text("Lista de Llaves"),
                selected: true,
              ),
              ListTile(
                title: Text("Mis Registros"),
              ),
            ]
        ),
      ),
    );
  }
}
class LlavesStateAdmin extends State<MenuLlaves>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Llaves"),
      ),
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
              DrawerHeader(child: Text("Canal 12")),
              ListTile(
                title: Text("Lista de Llaves"),
                selected: true,
              ),
              ListTile(
                title: Text("Lista de Registros"),
              ),
              ListTile(
                title: Text("Nueva Llave"),
              ),
            ]
        ),
      ),
    );
  }
}