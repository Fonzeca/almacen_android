import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MenuAlmacen extends StatefulWidget{
  bool admin;
  MenuAlmacen(this.admin);
  @override
  State<StatefulWidget> createState() {
    if (admin){
      return AlmacenStateAdmin();
    }
    return AlmacenState();
  }
}

//https://material.io/components/navigation-drawer/flutter#modal-navigation-drawer


class AlmacenStateAdmin extends State<MenuAlmacen> {
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Almacén"),
      ),
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
              DrawerHeader(child: Text("Canal 12")),
              ListTile(
                title: Text("Nuevo Pedido"),
                selected: true,
              ),
              ListTile(
                title: Text("Listar Pedidos"),
              ),
              ListTile(
                title: Text("Buscar Artículo"),
              ),
              ListTile(
                title: Text("Listar Artículos"),
              ),
              ListTile(
                title: Text("Listar Proveedores"),
              ),
              ListTile(
                title: Text("Artículo Nuevo"),
              ),
              ListTile(
                  title: Text("Proveedor Nuevo")
              ),

            ]
        ),
      ),
    );
  }
}
class AlmacenState extends State<MenuAlmacen> {
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Almacén"),
      ),
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Nuevo Pedido"),
                selected: true,
              ),
              ListTile(
                title: Text("Mis Pedidos"),
              ),

            ]
        ),
      ),
    );
  }
}