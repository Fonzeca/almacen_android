import 'dart:ui';

import 'package:almacen_android/packages/tecnica/bloc/bloc_listaEquipos_bloc.dart';
import 'package:almacen_android/packages/tecnica/model/equipo.dart';
import 'package:almacen_android/packages/tecnica/view/widget/modalEquipoEspecifico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListaEquipos extends StatelessWidget {
  Equipo equipo;

  ListaEquipos({Key key,this.equipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListaEquiposBloc>(context).add(
        ListaEquiposEventListarEquipos());

    if(equipo!=null){
      BlocProvider.of<ListaEquiposBloc>(context).add(
          (ListaEquiposEventGetDetalle(equipo.id.toString())));
    }
    return BlocListener<ListaEquiposBloc, ListaEquiposState>(
      listener: (context, state) {
        if(state.carga){
          EasyLoading.show();
        }else{
          EasyLoading.dismiss();
        }
        if (state.equipo != null) {
          crearModal(context, state.equipo);
        }
      },
      child: BlocBuilder<ListaEquiposBloc, ListaEquiposState>(
          builder: (context, state) {
            List <Equipo> _equipos = state.listaEquipos;
            if (_equipos == null) {
              _equipos = state.listaEquipos;
              return Container();
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: _equipos == null ? 1 : _equipos.length+1,
                  itemBuilder: (context, index){
                    if(index == 0){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Nombre",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Tipo",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Estado",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      );
                    }
                    index -=1;
                    return _createRow(_equipos[index], context, index);

                  });
            }
          }),
    );
  }

  Widget _createRow(Equipo p, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        EasyLoading.show();
        BlocProvider.of<ListaEquiposBloc>(context).add
          (ListaEquiposEventGetDetalle(p.id.toString()));

      },
      child: Dismissible(
          key: UniqueKey(),
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Atención!"),
                  content: const Text("¿Eliminar el equipo?"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("Eliminar")
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancelar"),
                    ),
                  ],
                );
              },
            );
          },

          onDismissed: (DismissDirection direction) {
            _eliminarEquipo(context, p.id);
          },
          background: Container(color: Colors.red,),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: Row(
                  children:
                  [
                    Expanded(child: Text(p.nombre,softWrap: true,textAlign: TextAlign.start,)),
                    Expanded(child: Text(p.tipo,softWrap: true, textAlign: TextAlign.center,)),
                    p.enUso ? Expanded(child: Text("En uso",softWrap: true, textAlign: TextAlign.end,)) : Expanded(child: Text("Disponible",style: TextStyle(color: Colors.green),softWrap: true, textAlign: TextAlign.end,)),
                  ]

              ),
            ),
          )),
    );
  }


  void crearModal(BuildContext context, Equipo detalleView) {
    EasyLoading.dismiss();
    ModalEquipo(context: context,detalleView: detalleView).abrirModal();
  }



  void _eliminarEquipo(BuildContext context, int idi) {
    String id = idi.toString();
    EasyLoading.showToast("Se hubiese eliminado el equipo número " + id+" si no fuera una Beta");
  }
}