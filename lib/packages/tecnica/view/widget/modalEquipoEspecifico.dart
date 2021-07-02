import 'package:almacen_android/packages/tecnica/bloc/bloc_grupo_equipos_bloc.dart';
import 'package:almacen_android/packages/tecnica/bloc/bloc_listaEquipos_bloc.dart';
import 'package:almacen_android/packages/tecnica/model/equipo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalEquipo{
  BuildContext context;
  Equipo detalleView;

  ModalEquipo({@required this.context, @required this.detalleView});

  void abrirModal({@required bool admin, @required String username, String nombre, String id}){
    if(!detalleView.enUso){
      admin = true;
    }else if(!admin && detalleView.usuario == username){
      admin = true;
    }
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text('Equipo:\n' +
                            detalleView.nombre, textAlign: TextAlign.center,),
                      ),
                      Expanded(child: Text('Tipo:\n' + detalleView.tipo, textAlign: TextAlign.center,)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: Text('Último usuario:\n' + detalleView.usuario, textAlign: TextAlign.center,)),

                      Expanded(child: Text('Lugar:\n' + detalleView.lugar, textAlign: TextAlign.center,)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: Text('Serial:\n' + detalleView.serial, textAlign: TextAlign.center,)),
                      Expanded(child: Text('Accesorios:\n' + detalleView.accesorios, textAlign: TextAlign.center,))
                    ],
                  ),
                  detalleView.enUso
                      ?
                  Text(
                    'Estado:\nEn Uso', style: TextStyle(color: Colors.red,fontSize: 18), textAlign: TextAlign.center,)
                      :
                  Text('Estado:\nDisponible',
                    style: TextStyle(color: Colors.green, fontSize: 18), textAlign: TextAlign.center,),
                  Divider(color: Colors.deepOrangeAccent, thickness: 1.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _crearBotones(admin, detalleView, nombre, id),
                    ),
                  )
                ],
              ),
            ),);
        });
  }

  List<Widget> _crearBotones(bool admin, Equipo detalleView, String nombre, String id){
    List<Widget> widgets = [];
    if(admin){
      widgets.add(ElevatedButton.icon(onPressed: () =>
          _cambiarEstadoEquipo(context, detalleView.id, nombre: nombre, id: id),
        label:
        detalleView.enUso?
        const Text('Entregar'):
        const Text('Retirar'),
        icon: const Icon(Icons.compare_arrows_outlined),
        style: ElevatedButton.styleFrom(
            primary: Colors.blue),));
    widgets.add(
        SizedBox(width: 40.0,));
    }
    widgets.add(
        ElevatedButton(
          child: const Text('Cerrar'),
          onPressed: () => Navigator.pop(context),
        ));
    return widgets;

  }
  void _cambiarEstadoEquipo(BuildContext context, int idi,{String nombre,String id}) {
    EasyLoading.showToast("Equipo número " + idi.toString() + " se cambió de estado.");
    BlocProvider.of<ListaEquiposBloc>(context).add(ListaEquipoEventCambiarEstadoEquipo(idi));
    if (nombre != null){
      BlocProvider.of<GrupoEquiposBloc>(context).add(
          GrupoEquiposEventSetGrupo(nombre,id));
    }
    Navigator.pop(context);
  }
}