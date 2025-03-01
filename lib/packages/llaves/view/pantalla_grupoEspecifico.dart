
import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart';
import 'package:almacen_android/packages/common/common_api_calls.dart';
import 'package:almacen_android/packages/llaves/bloc/bloc_grupo_bloc.dart';
import 'package:almacen_android/packages/llaves/model/grupoLlaves.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class GrupoEspecifico extends StatelessWidget {

  GrupoLlave grupoLlave;

  GrupoEspecifico({Key key, @required this.grupoLlave}) : super(key: key);

  final TextEditingController _controller = TextEditingController();



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
                          context, grupoState.estado, grupoState.grupoId.toString())
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
            _cambiarEstadoGrupo(context, "Disponible"),
          label:
          const Text('Retirar'),
          icon: const Icon(Icons.compare_arrows_outlined),
          style: ElevatedButton.styleFrom(
              primary: Colors.blue),);
        break;
      case "En uso":
        return ElevatedButton.icon(onPressed: () =>
            _cambiarEstadoGrupo(context, "En uso"),
          label:
          const Text('Entregar'),
          icon: const Icon(Icons.compare_arrows_outlined),
          style: ElevatedButton.styleFrom(
              primary: Colors.blue),);
        break;
      default:
    }
  }

  void _cambiarEstadoGrupo(BuildContext context, String entrada) {
    if(entrada == "Disponible"){
      String username;
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 400,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                            hintText: "Usuario al cual asignar la llave",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            )
                        ),
                        controller: _controller,
                      ),
                      suggestionsCallback: (pattern) async{
                        return CommonApiCalls().getUserLikeNombre(pattern);
                      },
                      noItemsFoundBuilder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("No se encontró", style: TextStyle(fontSize: 20, color: Colors.black26),),
                        );
                      },
                      hideOnError: false,
                      itemBuilder: (context, itemData) {
                        if(itemData == "NO HAY"){
                          return Container();
                        }else{
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(itemData),
                          );
                        }
                      },
                      onSuggestionSelected: (suggestion) {
                        print(suggestion+"<-");
                        _controller.text = suggestion;
                        username = suggestion;
                      },
                    ),
                  ),
                  TextButton(onPressed: () {
                    if(username != null){
                      BlocProvider.of<GrupoBloc>(context).add(GrupoEventCambiarEstado(username, "En uso"));
                      Navigator.pop(context);
                    }else{
                      EasyLoading.showToast("Debe seleccionar un usuario");
                    }

                  }, child: Text("OK")),
                ],
              ) ,
            );
          }

      );

    }else{
      BlocProvider.of<GrupoBloc>(context).add(GrupoEventCambiarEstado(null, "Disponible"));
    }


  }
}