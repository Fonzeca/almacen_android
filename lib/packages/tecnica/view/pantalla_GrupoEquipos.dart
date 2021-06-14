import 'package:almacen_android/packages/tecnica/bloc/bloc_grupo_equipos_bloc.dart';
import 'package:almacen_android/packages/tecnica/model/equipo.dart';
import 'package:almacen_android/packages/tecnica/model/grupoEquipo.dart';
import 'package:almacen_android/packages/tecnica/view/widget/modalEquipoEspecifico.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class GrupoEquiposEspecifico extends StatelessWidget{
  GrupoEquipo grupoEquipo;
  String _nombreGrupo = null;
  String _idGrupo = null;
  GrupoEquiposEspecifico({Key key,@required this.grupoEquipo}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    _nombreGrupo = grupoEquipo.nombre;
    _idGrupo = grupoEquipo.grupoId.toString();
    BlocProvider.of<GrupoEquiposBloc>(context).add(
        GrupoEquiposEventSetGrupo(_nombreGrupo,_idGrupo));
    return BlocListener<GrupoEquiposBloc, GrupoEquiposState>(
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
        child: BlocBuilder<GrupoEquiposBloc, GrupoEquiposState>(
            builder: (context, state) {
              GrupoEquipo grupoState = state.grupo;
              if (grupoState == null) {
                grupoState = state.grupo;
                return Container();
              } else {
                return Container(
                    height: double.infinity,
                    child: Center(
                        child: Column(
                            children: <Widget>[
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text('Nombre:\n' +
                                        grupoState.nombre, textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                                  ),
                                  Expanded(child: Text('Estado:\n' + grupoState.estado, textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
                                ],
                              ),
                              Divider(color: Colors.deepOrangeAccent, thickness: 1.0,),
                              Text("Equipos", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: grupoState.equipos == null ? 1 : grupoState.equipos.length+1,
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
                                    return _createRow(grupoState.equipos[index], context, index);

                                  }
                              ),
                              Divider(color: Colors.deepOrangeAccent, thickness: 1.0,),
                              _crearBotones(context, grupoState.estado),

                            ]
                        )
                    )
                );
              }
            }
        )
    );
  }

  Widget _createRow(Equipo p, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        EasyLoading.show();
        BlocProvider.of<GrupoEquiposBloc>(context).add
          (GrupoEquiposEventSetEquipo(p.id.toString()));

      },
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
      ),
    );
  }
  Widget _crearBotones(BuildContext context, String estado){
    switch (estado){
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
  void _cambiarEstadoGrupo(BuildContext context, String idGrupo){


  }
  void crearModal(BuildContext context, Equipo detalleView) {
    EasyLoading.dismiss();
    ModalEquipo(context: context,detalleView: detalleView).abrirModal(nombre: _nombreGrupo,id: _idGrupo);
  }
}