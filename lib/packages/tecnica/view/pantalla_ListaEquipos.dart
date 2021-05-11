import 'package:almacen_android/packages/almacen/bloc/bloc_almacen_bloc.dart';
import 'package:almacen_android/packages/tecnica/bloc/bloc_listaEquipos_bloc.dart';
import 'package:almacen_android/packages/tecnica/model/equipo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListaEquipos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListaEquiposBloc>(context).add(
        ListaEquiposEventListarEquipos());
    return BlocListener<ListaEquiposBloc, ListaEquiposState>(
      listener: (context, state) {
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
        BlocProvider.of<ListaEquiposBloc>(context).add(
            (ListaEquiposEventGetDetalle(p.id.toString())));

      },
      child: Dismissible(
          key: Key(p.toString()),
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
            color: index.isEven ? Colors.white : Colors.black12,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Text(p.nombre),
                    Text(p.tipo),
                    p.enUso ? Text("En uso",) : Text("Disponible",),
                  ]

              ),
            ),
          )),
    );
  }


  void crearModal(BuildContext context, Equipo equipo) {
    Equipo detalleView = equipo;
    EasyLoading.dismiss();
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(height: 250,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Equipo: ' +
                            detalleView.nombre),
                        Text('Tipo: ' + detalleView.tipo),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Usuario: ' + detalleView.usuario),
                      detalleView.enUso
                          ?
                      Text(
                        'Estado: En Uso', style: TextStyle(color: Colors.red),)
                          :
                      Text('Estado: Disponible',
                          style: TextStyle(color: Colors.green)),
                      Text('Lugar: ' + detalleView.lugar),
                    ],
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Serial: ' + detalleView.serial),
                      Text('Modelo: ' + detalleView.modelo),
                      Text('Accesorios: ' + detalleView.accesorios)
                    ],
                  ),
                  Text('Observaciones: ' + detalleView.observaciones),
                  Divider(color: Colors.deepOrangeAccent, thickness: 1.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(onPressed: () =>
                            _cambiarEstadoEquipo(context, detalleView.id),
                          label: const Text('Cambiar Estado'),
                          icon: const Icon(Icons.compare_arrows_outlined),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue),),
                        SizedBox(width: 40.0,),
                        ElevatedButton(
                          child: const Text('Cerrar'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),);
        });
  }

  void _cambiarEstadoEquipo(BuildContext context, int idi) {

    EasyLoading.showToast("Equipo número " + idi.toString() + " se cambió de estado.");
    BlocProvider.of<ListaEquiposBloc>(context).add(ListaEquipoEventCambiarEstadoEquipo(idi));
    BlocProvider.of<ListaEquiposBloc>(context).add(ListaEquipoEventLimpiarEquipo());
    Navigator.pop(context);
  }

  void _eliminarEquipo(BuildContext context, int idi) {
    String id = idi.toString();
    EasyLoading.showToast("Se hubiese eliminado el equipo número " + id+" si no fuera una Beta");
  }
}