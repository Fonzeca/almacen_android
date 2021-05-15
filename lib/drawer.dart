import 'package:almacen_android/main.dart';
import 'package:almacen_android/packages/almacen/view/pantalla_agregarStock.dart';
import 'package:almacen_android/packages/almacen/view/pantallasAlmacen.dart';
import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart';
import 'package:almacen_android/packages/common/common_api_calls.dart';
import 'package:almacen_android/packages/common/view/ScanScreen.dart';
import 'package:almacen_android/packages/tecnica/view/pantallasTecnica.dart';
import 'package:almacen_android/packages/llaves/view/pantallasLlaves.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart' as BlocNavigator;

class MainDrawer extends StatelessWidget{

  bool admin;
  ValueNotifier<int> valueNotifier;
  String appTitle;


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

    return BlocBuilder<NavigatorBloc,BlocNavigator.NavigatorState>(
      builder: (context, state){

        //TODO: quitar los value listenable para usar BLoC.

        return Scaffold(
          appBar: AppBar(
            title: ValueListenableBuilder(
              builder: (BuildContext context, value, Widget child) {
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
                    _drawerItem(sections[0], Icon(Icons.arrow_right_rounded), 0, values, context),
                    //        Listar Pedido
                    ListTile(
                      title: Text(sections[1]),
                      leading: Icon(Icons.arrow_right_rounded),
                      selected: valueNotifier.value == 1,
                      onTap: () => _cerrarDrawer(context, 1),
                    ),
                    //        Listar Artículos
                    admin?ListTile(
                      title: Text("Agregar Stock"),
                      leading: Icon(Icons.arrow_right_rounded),
                      selected: valueNotifier.value == 2,
                      onTap:()=> _cerrarDrawer(context, 2),
                    ):SizedBox(),
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
                      title: Text(sections[12]),
                      leading: Icon(Icons.arrow_right_rounded),
                      selected: valueNotifier.value ==20,
                      onTap: () => _cerrarDrawer(context, 20),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      title: Text("Scannear"),
                      leading: Icon(Icons.qr_code),
                      selected: valueNotifier.value == 50,
                      onTap: ()=> _cerrarDrawer(context, 50),
                    ),
                    SizedBox(height: 20.0,),
                    ListTile(
                      title: Text("Cerrar Sesión"),
                      leading: Icon(Icons.logout),
                      selected: valueNotifier.value==99,
                      onTap: () => _cerrarDrawer(context,99),
                    )
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
                  appTitle="Nuevo Pedido";
                  return NuevoPedido(admn: admin,);
                case 1:
                  appTitle="Lista de Pedidos";
                  return ListaPedidos(admn: admin,);
                case 2:
                  appTitle="Agregar Stock";
                  return AgregarStock();
                case 10:
                  appTitle="Lista de Equipos";
                  return ListaEquipos();
                case 11:
                  appTitle="Lista de Registros";
                  return ListaRegistros(admn: admin,);
                case 20:
                  appTitle="Llaves";
                  return BuscarLlave();
                case 50:
                  appTitle="Scannear QR";
                  return ScanScreen();
                case 99:
                  CommonApiCalls commonApiCalls= CommonApiCalls();
                  commonApiCalls.logout().then((value) {
                    return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> MyHomePage()), (route) => false);
                  });
              }
              return Container();
            },
            valueListenable: valueNotifier,
          ),
        );
      },

    );
  }
  void _cerrarDrawer (BuildContext context, int value){
    valueNotifier.value=value;
    Navigator.of(context).pop();

  }
  ListTile _drawerItem(String title, Icon leading, int value, List<int> values, BuildContext context){
    return ListTile(
      title: Text(title),
      leading: leading,
      selected: value == values.last,
      onTap: ()=>BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPushPage(value)),

    );
  }

}

