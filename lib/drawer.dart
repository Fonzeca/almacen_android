import 'package:almacen_android/main.dart';
import 'package:almacen_android/packages/almacen/view/pantalla_agregarStock.dart';
import 'package:almacen_android/packages/almacen/view/pantallasAlmacen.dart';
import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart';
import 'package:almacen_android/packages/common/common_api_calls.dart';
import 'package:almacen_android/packages/common/view/ScanScreen.dart';
import 'package:almacen_android/packages/llaves/view/pantalla_llavesposesion.dart';
import 'package:almacen_android/packages/tecnica/view/pantalla_GrupoEquipos.dart';
import 'package:almacen_android/packages/tecnica/view/pantallasTecnica.dart';
import 'package:almacen_android/packages/llaves/view/pantallasLlaves.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart' as BlocNavigator;

class MainDrawer extends StatelessWidget{

  bool admin;
  String rol;
  String userId;
  String appTitle;
  Icon leadingArrow;


  /// En la lista de 'sections' se agregaron todas las funcionalidades posibles aunque solo se utilizan algunas, esto es para preveer que se incluyan mas funcionalidades en un futuro.

  List<String> sections = [
    "Nuevo Pedido", //0
    "Listar Pedidos",
    "Listar Artículos",
    "Listar Proveedores",
    "Nuevo Artículo",
    "Nuevo Proveedor", //5
    "Listar Equipos",
    "Listar Registros",
    "Nuevo Equipo",
    "Nuevo Tipo",
    "Nuevo Lugar", //10
    "Escanear Llave",
    "Buscar Llave",
    "Llaves en posesión",
    "Nueva Llave",
    "Nuevo Grupo", //15
    "Agregar Stock",
  ];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainDrawer (bool admin, String rol, String id, BuildContext context){
    this.admin = admin;
    this.rol = rol;
    this.userId = id;
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPushPage(0));
  }

  /// Se utilizan los valores en decenas para permitir agregar funcionalidades en caso de ser necesario.
  /// Almacen abarca de los valores 0-9, Tecnica de 10-19 y Llaves de 20-29.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    leadingArrow = Icon(Icons.arrow_right_rounded);
    Widget body;
    Widget trailingAppBar;

    return BlocBuilder<NavigatorBloc,BlocNavigator.NavigatorState>(
      builder: (context, state){
        trailingAppBar = null;
        appTitle = "";
        body = null;
        switch (state.values.last){
          case 0:
            appTitle = "Nuevo Pedido";
            if(state.parametro!=null){
              body = NuevoPedido(admn: admin, nombreArticulo: state.parametro,);
              break;
            }
            body = NuevoPedido(admn: admin,);
            trailingAppBar = Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: GestureDetector(onTap: (body as NuevoPedido).scannearMultiplesArticulos, child: Icon(Icons.qr_code)));
            break;
          case 1:
            appTitle="Lista de Pedidos";
            body = ListaPedidos(admn: admin,);
            trailingAppBar = Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: GestureDetector(onTap: (body as ListaPedidos).abrirFilter, child: Icon(Icons.tune)));
            break;
          case 2:
            appTitle="Agregar Stock";
            body = AgregarStock();
            break;
          case 10:
            appTitle="Lista de Equipos";
            if(state.parametro != null){
              body = ListaEquipos(equipo: state.parametro,);
              break;
            }
            body = ListaEquipos();
            break;
          case 11:
            appTitle="Lista de Registros";
            body = ListaRegistros(admn: admin,);
            break;
          case 12:
            appTitle="Grupo Equipos Específico";
            body = GrupoEquiposEspecifico(grupoEquipo: state.parametro);
            break;
          case 20:
            appTitle="Llaves";
            body = BuscarLlave();
            break;
          case 21:
            appTitle="Llave Específica";
            body = LlaveEspecifica(id: state.parametro);
            break;
          case 22:
            appTitle="Grupo Llaves Específico";
            body = GrupoEspecifico(grupoLlave: state.parametro);
            break;
          case 23:
            appTitle="Llaves en Posesión";
            body = LlavesPosesion(admn: admin, id: userId,);
            break;
          case 50:
            appTitle="Scannear QR";
            body = ScanScreen(llaves: state.parametro,);
            break;
          case 99:
            appTitle = "";
            body = Container();
            CommonApiCalls commonApiCalls= CommonApiCalls();
            commonApiCalls.logout().then((value) {
              BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventResetNavigator());
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> MyHomePage()), (route) => false);
            });
            break;
          default :
            appTitle = "";
            body = Container();
            break;
        }
        return WillPopScope(
          onWillPop: () async{
            if(state.values.last == -1 || state.values.length == 1){
              return true;
            }else if (_scaffoldKey.currentState.isDrawerOpen) {
              Navigator.of(context).pop();
              return false;
            }else{
              BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventGetBack());
              return false;
            }
          },
          child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(appTitle),
                actions: [trailingAppBar ?? Container()],
              ),
              body: body,
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
                      _resolverMenuByRol(state,context),
                    ],
                  )
              )
          ),
        );
      },

    );

  }

  Widget _bloqueAlmacen(bool nuevoPedido, bool listarPedido, bool agregarStock, BlocNavigator.NavigatorState state, BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Almacén',
          ),
        ),
        _drawerItem(sections[0], leadingArrow, 0, state.values, context, nuevoPedido),
        _drawerItem(sections[1], leadingArrow, 1, state.values, context, listarPedido),
        _drawerItem(sections[16], leadingArrow, 2, state.values, context, agregarStock),
      ],
    );
  }

  Widget _bloqueTecnica(bool listarEquipos, BlocNavigator.NavigatorState state, BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Técnica',
          ),
        ),
        _drawerItem(sections[6], leadingArrow, 10, state.values, context, listarEquipos),
      ],
    );
  }

  Widget _bloqueLlaves(bool buscarLlave, bool llavesEnPosesion, BlocNavigator.NavigatorState state, BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Llaves',
          ),
        ),
        _drawerItem(sections[12], leadingArrow, 20, state.values, context, buscarLlave),
        _drawerItem(sections[13], leadingArrow, 23, state.values, context, llavesEnPosesion),
      ],
    );
  }

  Widget _drawerItem(String title, Icon leading, int value, List<int> values, BuildContext context, [bool esta = true]){
    if(esta){
      return ListTile(
          title: Text(title),
          leading: leading,
          selected: value == values.last,
          onTap: (){
            Navigator.of(context).pop();
            if(value == 50){
              BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPushPage(value, parametro: rol=='SuperAdmin' || rol == 'Administrador Llaves'));
            }else{
              BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPushPage(value));
            }
          }

      );
    }else{
      return Container();
    }
  }

  Widget _divider(){
    return Divider(
      height: 1,
      thickness: 1,
    );
  }

  Widget _resolverMenuByRol(BlocNavigator.NavigatorState state, BuildContext context){
    if(rol == "Administrador Llaves"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bloqueAlmacen(true, false, false, state, context),
          _divider(),
          _bloqueTecnica(true, state, context),
          _divider(),
          _bloqueLlaves(true, true, state, context),
          _divider(),
          _drawerItem("Scannear", Icon(Icons.qr_code), 50, state.values, context),
          SizedBox(height: 20.0,),
          _drawerItem("Cerrar Sesión", Icon(Icons.logout), 99, state.values, context),
        ],
      );
    }else if(rol == "Administrador"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bloqueAlmacen(true, true, true, state, context),
          _divider(),
          _drawerItem("Scannear", Icon(Icons.qr_code), 50, state.values, context),
          SizedBox(height: 20.0,),
          _drawerItem("Cerrar Sesión", Icon(Icons.logout), 99, state.values, context),
        ],
      );
    }else if(rol == "Administrador Tecnica"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bloqueAlmacen(true, false, false, state, context),
          _divider(),
          _bloqueTecnica(true, state, context),
          _divider(),
          _drawerItem("Scannear", Icon(Icons.qr_code), 50, state.values, context),
          SizedBox(height: 20.0,),
          _drawerItem("Cerrar Sesión", Icon(Icons.logout), 99, state.values, context),
        ],
      );
    }else if(rol == "Solicitante"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bloqueAlmacen(true, true, false, state, context),
          _divider(),
          _bloqueTecnica(true, state, context),
          _divider(),
          _bloqueLlaves(true, true, state, context),
          _divider(),
          _drawerItem("Scannear", Icon(Icons.qr_code), 50, state.values, context),
          SizedBox(height: 20.0,),
          _drawerItem("Cerrar Sesión", Icon(Icons.logout), 99, state.values, context),
        ],
      );
    }else if(rol == "SuperAdmin"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bloqueAlmacen(true, true, true, state, context),
          _divider(),
          _bloqueTecnica(true, state, context),
          _divider(),
          _bloqueLlaves(true, true, state, context),
          _divider(),
          _drawerItem("Scannear", Icon(Icons.qr_code), 50, state.values, context),
          SizedBox(height: 20.0,),
          _drawerItem("Cerrar Sesión", Icon(Icons.logout), 99, state.values, context),
        ],
      );
    }else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bloqueAlmacen(true, false, false, state, context),
          _divider(),
          SizedBox(height: 20.0,),
          _drawerItem("Cerrar Sesión", Icon(Icons.logout), 99, state.values, context),
        ],
      );
    }
  }

}

