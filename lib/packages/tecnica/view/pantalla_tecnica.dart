import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MenuTecnica extends StatefulWidget{
  bool admin;
  MenuTecnica(this.admin);
  @override
  State<StatefulWidget> createState() {
    if (admin){
      return TecnicaStateAdmin();
    }
    return TecnicaState();
  }
}

class TecnicaState extends State<MenuTecnica>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Técnica"),
      ),
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
              DrawerHeader(child: Text("Canal 12")),
              ListTile(
                title: Text("Lista de Equipos"),
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

class TecnicaStateAdmin extends State<MenuTecnica>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Técnica"),
      ),
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
              DrawerHeader(child: Text("Canal 12")),
              ListTile(
                title: Text("Lista de Equipos"),
                selected: true,
              ),
              ListTile(
                title: Text("Lista de Registros"),
              ),
              ListTile(
                title: Text("Nuevo Equipo"),
              ),
              ListTile(
                title: Text("Nuevo Tipo"),
              ),
              ListTile(
                title: Text("Nuevo Lugar"),
              ),
            ]
        ),
      ),
    );
  }
}
