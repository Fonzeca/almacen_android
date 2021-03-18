import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget{

  bool admin;
  ValueNotifier<int> valueNotifier;

  List<String> sections =["Nuevo Pedido", "Listar Pedidos", "Listar Artículos", "Listar Proveedores","Nuevo Artículo","Nuevo Proveedor",
    "Listar Equipos","Listar Registros","Nuevo Equipo","Nuevo Tipo","Nuevo Lugar",
    "Escanear Llave", "Listar Llaves","Nueva Llave","Nuevo Grupo"];
  String appTitle = 'Bienvenido';

  MainDrawer (admin,value){
   this.admin=admin;
   valueNotifier = ValueNotifier(value);
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    if(valueNotifier.value<6){
      appTitle="Almacén";
    }else if(valueNotifier.value<11){
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
            ListTile(
              title: Text(sections[0]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==0,
              onTap: () => valueNotifier.value=0,
            ),
            ListTile(
              title: Text(sections[1]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value == 1,
              onTap: () => valueNotifier.value=1,
            ),
            ListTile(
              title: Text(sections[2]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value == 2,
              onTap: () => valueNotifier.value=2,
            ),
            ListTile(
              title: Text(sections[3]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==3,
              onTap: () => valueNotifier.value=3,
            ),
            ListTile(
              title: Text(sections[4]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==4,
              onTap: () => valueNotifier.value=4,
            ),
            ListTile(
              title: Text(sections[5]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==5,
              onTap: () => valueNotifier.value=5,
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
            ListTile(
              title: Text(sections[6]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==6,
              onTap: () => valueNotifier.value=6,
            ),   ListTile(
              title: Text(sections[7]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==7,
              onTap: () => valueNotifier.value=7,
            ),   ListTile(
              title: Text(sections[8]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==8,
              onTap: () => valueNotifier.value=8,
            ),   ListTile(
              title: Text(sections[9]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==9,
              onTap: () => valueNotifier.value=9,
            ),   ListTile(
              title: Text(sections[10]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==10,
              onTap: () => valueNotifier.value=10,
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
            ),   ListTile(
              title: Text(sections[11]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==11,
              onTap: () => valueNotifier.value=11,
            ),   ListTile(
              title: Text(sections[12]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==12,
              onTap: () => valueNotifier.value=12,
            ),   ListTile(
              title: Text(sections[13]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==13,
              onTap: () => valueNotifier.value=13,
            ),   ListTile(
              title: Text(sections[14]),
              leading: Icon(Icons.arrow_right_rounded),
              selected: valueNotifier.value ==14,
              onTap: () => valueNotifier.value=14,
            ),
          ],
        ),
      ),
    );
  }
}