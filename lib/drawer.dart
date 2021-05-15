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
  String appTitle;
  Icon leadingArrow;


  /// En la lista de 'sections' se agregaron todas las funcionalidades posibles aunque solo se utilizan algunas, esto es para preveer que se incluyan mas funcionalidades en un futuro.

  List<String> sections =["Nuevo Pedido", "Listar Pedidos", "Listar Artículos", "Listar Proveedores","Nuevo Artículo","Nuevo Proveedor",
    "Listar Equipos","Listar Registros","Nuevo Equipo","Nuevo Tipo","Nuevo Lugar",
    "Escanear Llave", "Listar Llaves","Nueva Llave","Nuevo Grupo"];

  MainDrawer (bool admin){
    this.admin=admin;
  }

  /// Se utilizan los valores en decenas para permitir agregar funcionalidades en caso de ser necesario.
  /// Almacen abarca de los valores 0-9, Tecnica de 10-19 y Llaves de 20-29.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    leadingArrow = Icon(Icons.arrow_right_rounded);

    return BlocBuilder<NavigatorBloc,BlocNavigator.NavigatorState>(
      builder: (context, state){
        switch (state.values.last){
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
        return Scaffold(
          appBar: AppBar(
            title: Text(appTitle),
          ),
          drawer: Drawer(
            child: ListView(
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
                    _drawerItem(sections[0], leadingArrow, 0, state.values, context),
                    //
                    _drawerItem(sections[1], leadingArrow, 1, state.values, context),
                    admin?_drawerItem("Agregar Stock", leadingArrow, 2, state.values, context)
                    :SizedBox(),
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
                    _drawerItem(sections[6], leadingArrow, 10, state.values, context),
                    //          Listar Registros
                    _drawerItem(sections[7], leadingArrow, 11, state.values, context),
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
                    _drawerItem(sections[12], leadingArrow, 20, state.values, context),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    _drawerItem("Scannear", Icon(Icons.qr_code), 50, state.values, context),
                    SizedBox(height: 20.0,),
                    _drawerItem("Cerrar Sesión", Icon(Icons.logout), 99, state.values, context),
                    //          Listar Llaves
                  ],
                )
        )
        );
      },

    );
  }
  ListTile _drawerItem(String title, Icon leading, int value, List<int> values, BuildContext context){
    return ListTile(
      title: Text(title),
      leading: leading,
      selected: value == values.last,
      onTap: (){
        Navigator.of(context).pop();
        BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPushPage(value));},

    );
  }

}

