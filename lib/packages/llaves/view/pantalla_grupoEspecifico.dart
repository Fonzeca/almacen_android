
import 'package:almacen_android/packages/llaves/bloc/bloc_grupo_bloc.dart';
import 'package:almacen_android/packages/llaves/model/grupoLlaves.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GrupoEspecifico extends StatelessWidget{

  GrupoLlave grupoLlave;
  GrupoEspecifico({Key key, @required this.grupoLlave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GrupoBloc>(context).add(GrupoEventSetGrupo(grupoLlave));
    return BlocListener<GrupoBloc, GrupoState>(
      listener: (context, state){
        if(state.carga){
          EasyLoading.show();
        }else{
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<GrupoBloc, GrupoState>(
        builder: (context, state){
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
                        Text(grupoLlave.nombre),
                        Text(grupoLlave.estado),
                      ],),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: grupoLlave.llaves == null ? 1 : grupoLlave.llaves.length +1,
                        itemBuilder: (context, index){
                          if(index == 0){
                            return Card(
                                child:Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Nombre"),
                                      Text("Estado")
                                    ],
                                  ),
                                )
                            );
                          }
                          index -=1;
                          return Card(
                              color: index.isEven ? Colors.white : Colors.black12,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:
                                      [
                                        Text(grupoLlave.llaves[index].nombre),
                                        Text(grupoLlave.llaves[index].estado),
                                      ]
                                  )
                              )
                          );
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),);

  }

}