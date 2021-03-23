import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget{

  bool admin;
  ValueNotifier<int> valueNotifier;

  Servidor _servidor = Servidor();

  List<Articulo> arts;

  /**
   * En la lista de 'sections' se agregaron todas las funcionalidades posibles aunque solo se utilizan algunas, esto es para preveer que se incluyan mas funcionalidades en un futuro.
   */
  List<String> sections =["Nuevo Pedido", "Listar Pedidos", "Listar Artículos", "Listar Proveedores","Nuevo Artículo","Nuevo Proveedor",
    "Listar Equipos","Listar Registros","Nuevo Equipo","Nuevo Tipo","Nuevo Lugar",
    "Escanear Llave", "Listar Llaves","Nueva Llave","Nuevo Grupo"];
  String appTitle = 'Bienvenido';

  MainDrawer (admin,value){
    this.admin=admin;
    valueNotifier = ValueNotifier(value);
  }

  /**
   * Se crea el drawer en sí, valueNotifier.value determina cual opción fue seleccionada.
   * Se utilizan los valores en decenas para permitir agregar funcionalidades en caso de ser necesario.
   * Almacen abarca de los valores 0-9, Tecnica de 10-19 y Llaves de 20-29.
   */
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    if(valueNotifier.value<10){
      appTitle="Almacén";
    }else if(valueNotifier.value<20){
      appTitle="Técnica";
    }else appTitle="Llaves";

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
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
              onTap: () => valueNotifier.value=0,
            ),
            //        Listar Pedido
            ListTile(
              title: Text(sections[1]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value == 1,
              onTap: () => valueNotifier.value=1,
            ),
            //        Listar Artículos
            ListTile(
                title: Text(sections[2]),
                leading: Icon(Icons.arrow_right_rounded),
                selected: valueNotifier.value == 2,
                onTap: () {valueNotifier.value=2;
                _servidor.listarArticulos().then((value) => arts=value);

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
              onTap: () => valueNotifier.value=10,
            ),
            //          Listar Registros
            ListTile(
              title: Text(sections[7]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==11,
              onTap: () => valueNotifier.value=11,
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
              onTap: () => valueNotifier.value=20,
            ),
            //          Listar Llaves
            ListTile(
              title: Text(sections[12]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==21,
              onTap: () => valueNotifier.value=21,
            ),
          ],
        ),
      ),
    );
  }
}