import 'package:almacen_android/packages/almacen/view/pantallasAlmacen.dart';
import 'package:almacen_android/packages/tecnica/view/pantallasTecnica.dart';
import 'package:almacen_android/packages/llaves/view/pantallasLlaves.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget{

  bool admin;
  ValueNotifier<int> valueNotifier;


  /// En la lista de 'sections' se agregaron todas las funcionalidades posibles aunque solo se utilizan algunas, esto es para preveer que se incluyan mas funcionalidades en un futuro.

  List<String> sections =["Nuevo Pedido", "Listar Pedidos", "Listar Artículos", "Listar Proveedores","Nuevo Artículo","Nuevo Proveedor",
    "Listar Equipos","Listar Registros","Nuevo Equipo","Nuevo Tipo","Nuevo Lugar",
    "Escanear Llave", "Listar Llaves","Nueva Llave","Nuevo Grupo"];

  MainDrawer (bool admin){
    this.admin=admin;
    valueNotifier = ValueNotifier(0);
  }

  /// Se crea el drawer en sí, valueNotifier.value determina cual opción fue seleccionada.
  /// Se utilizan los valores en decenas para permitir agregar funcionalidades en caso de ser necesario.
  /// Almacen abarca de los valores 0-9, Tecnica de 10-19 y Llaves de 20-29.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          builder: (BuildContext context, value, Widget child) {
            String appTitle;
            if(value < 10){
              appTitle="Almacén";
            }else if(value < 20){
              appTitle="Técnica";
            }else appTitle="Llaves";
            return Text(appTitle);
          },
          valueListenable: valueNotifier,
        ),
      ),
      drawer: Drawer(
        child: ValueListenableBuilder(
          builder: (context, value, child) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Canal 12',
                    style: textTheme.headline6,
                  ),
                ),

                Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Almacén',
                  ),
                ),
                //        Nuevo Pedido
                ListTile(
                  title: Text(sections[0]),
                  leading: Icon(Icons.arrow_right_rounded),
                  selected: valueNotifier.value ==0,
                  onTap: () => _cerrarDrawer(context, 0),
                ),
                //        Listar Pedido
                ListTile(
                  title: Text(sections[1]),
                  leading: Icon(Icons.arrow_right_rounded),
                  selected: valueNotifier.value == 1,
                  onTap: () => _cerrarDrawer(context, 1),
                ),
                //        Listar Artículos
                ListTile(
                    title: Text(sections[2]),
                    leading: Icon(Icons.arrow_right_rounded),
                    selected: valueNotifier.value == 2,
                    onTap: () {
                      _cerrarDrawer(context,2);

                    }
                ),

                Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Técnica',
                  ),
                ),
                //          Listar Equipos
                ListTile(
                  title: Text(sections[6]),
                  leading: Icon(Icons.arrow_right_rounded),
                  selected: valueNotifier.value ==10,
                  onTap: () => _cerrarDrawer(context, 10),
                ),
                //          Listar Registros
                ListTile(
                  title: Text(sections[7]),
                  leading: Icon(Icons.arrow_right_rounded),
                  selected: valueNotifier.value ==11,
                  onTap: () => _cerrarDrawer(context, 11),
                ),

                Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Llaves',
                  ),
                ),
                //          Escanear Llave
                ListTile(
                  title: Text(sections[11]),
                  leading: Icon(Icons.arrow_right_rounded),
                  selected: valueNotifier.value ==20,
                  onTap: () => _cerrarDrawer(context, 20),
                ),
                //          Listar Llaves
              ],
            );
          },
          valueListenable: valueNotifier,
        ),
      ),
      body: ValueListenableBuilder(
        builder: (context, value, child) {
          switch(value){
            case 0:
              return NuevoPedido();
            case 1:
              return ListaPedidos();
            case 2:
            case 10:
              return ListaEquipos();
            case 11:
              return ListaRegistros();
            case 20:
              return ScanLlaves();
          }
          return Container();
        },
        valueListenable: valueNotifier,
      ),
    );
  }
  void _cerrarDrawer (BuildContext context, int value){
    valueNotifier.value=value;
    Navigator.of(context).pop();

  }

}

