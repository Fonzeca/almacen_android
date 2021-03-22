import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/articulo.dart';
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


class AlmacenStateAdmin extends State<MenuAlmacen> {
  Servidor _servidor = Servidor();
  List<Articulo> arts;
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
              ),
              ListTile(
                title: Text("Listar Pedidos"),
              ),
              ListTile(
                title: Text("Buscar Artículo"),
              ),
              ListTile(
                title: Text("Listar Artículos"),
                onTap: () {
                  print("fonzo trolo");
                  _servidor.listarArticulos().then((value) => arts=value);
                },
                onLongPress:()=> print("fonzo puto"),
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