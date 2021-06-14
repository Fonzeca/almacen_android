
import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart';
import 'package:almacen_android/packages/llaves/bloc/bloc_grupo_bloc.dart';
import 'package:almacen_android/packages/llaves/model/grupoLlaves.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GrupoEspecifico extends StatelessWidget {

  GrupoLlave grupoLlave;

  GrupoEspecifico({Key key, @required this.grupoLlave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GrupoBloc>(context).add(
        GrupoEventSetGrupo(grupoLlave.grupoId.toString(), grupoLlave.nombre));
    return BlocListener<GrupoBloc, GrupoState>(
      listener: (context, state) {
        if (state.carga) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }
        if (state.llave != null) {
          BlocProvider.of<NavigatorBloc>(context).add(
              NavigatorEventPushPage(21, parametro: state.llave.id));
        }
      },
      child: BlocBuilder<GrupoBloc, GrupoState>(
        builder: (context, state) {
          GrupoLlave grupoState = state.grupoLlave;
          if (grupoState == null) {
            grupoState = state.grupoLlave;
            return Container();
          } else {
            return Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                  Row(
                  children: [
                  Expanded(
                  child: Text('Nombre:\n' +
                  grupoState.nombre, textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),),
                ),
                Expanded(child: Text(
                  'Estado:\n' + grupoState.estado, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),)),
                ],
              ),
              Divider(color: Colors.deepOrangeAccent, thickness: 1.0,),
              Text("Llaves",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: grupoState.llaves == null ? 1 : grupoState.llaves
                      .length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Llave", style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                                Text("Copia", style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                                Text("Estado", style: TextStyle(
                                    fontWeight: FontWeight.bold))
                              ],
                            ),
                          )
                      );
                    }
                    index -= 1;
                    return GestureDetector(
                      onTap: () {
                        EasyLoading.show();
                        BlocProvider.of<GrupoBloc>(context).add
                          (GrupoEventSetLlave(grupoState.llaves[index].id));
                      },
                      child: Card(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children:
                                  [
                                    Text(grupoState.llaves[index].nombre),
                                    Text(grupoState.llaves[index].copia),
                                    Text(grupoState.llaves[index].estado),
                                  ]
                              )
                          )
                      ),
                    );
                  }),
              Divider(color: Colors.deepOrangeAccent, thickness: 1.0,),
              _crearBotones(
                  context, grupoState.estado, grupoState.grupoId.toString());
              ],
            ),)
          ,
          )
          ,
          );
        }
        },
      ),);
  }

  Widget _crearBotones(BuildContext context, String estado, String _idGrupo) {
    switch (estado) {
      case "Disponible":
        return ElevatedButton.icon(onPressed: () =>
            _cambiarEstadoGrupo(context, _idGrupo),
          label:
          const Text('Retirar'),
          icon: const Icon(Icons.compare_arrows_outlined),
          style: ElevatedButton.styleFrom(
              primary: Colors.blue),);
        break;
      case "En uso":
        return ElevatedButton.icon(onPressed: () =>
            _cambiarEstadoGrupo(context, _idGrupo),
          label:
          const Text('Entregar'),
          icon: const Icon(Icons.compare_arrows_outlined),
          style: ElevatedButton.styleFrom(
              primary: Colors.blue),);
        break;
      default:
    }
  }

  void _cambiarEstadoGrupo(BuildContext context, String idGrupo) {


  }
}