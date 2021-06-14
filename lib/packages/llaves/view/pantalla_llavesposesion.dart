import 'package:almacen_android/packages/llaves/bloc/bloc_posesion_bloc.dart';
import 'package:almacen_android/packages/llaves/model/modelLlaves.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LlavesPosesion extends StatelessWidget{
  bool admn;
  LlavesPosesion({Key key, @required this.admn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(admn){
      BlocProvider.of<PosesionBloc>(context).add(PosesionEventCargarLista());
    }else{
      BlocProvider.of<PosesionBloc>(context).add(PosesionEventCargarListaPropia("13"));
    }
    return BlocListener<PosesionBloc, PosesionState>(
      listener: (context, state) {
        if(state.carga){
          EasyLoading.show();
        }else{
          EasyLoading.dismiss();
        }
      },
      child: BlocBuilder<PosesionBloc, PosesionState>(builder: (context, state) {
        List<Llave> _llavesEnPosesion = state.llaves;
        if(_llavesEnPosesion == null){
          _llavesEnPosesion = state.llaves;
          return Container();
        }else{
          return ListView.builder(
              shrinkWrap: true,
              itemCount: _llavesEnPosesion == null ? 1 : _llavesEnPosesion.length+1,
              itemBuilder: (context, index){
                if(index == 0){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Nombre",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Copia",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Usuario",textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                }
                index -=1;
                return _createRow(_llavesEnPosesion[index], context, index);

              });
        }
      },
      ),);
  }
  Widget _createRow(Llave p, BuildContext context, int index) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 4.0),
        child: Row(
            children:
            [
              Expanded(child: Text(p.nombre,softWrap: true,textAlign: TextAlign.start,)),
              Expanded(child: Text(p.copia,softWrap: true, textAlign: TextAlign.center,)),
              Expanded(child: Text(p.usuario,softWrap: true, textAlign: TextAlign.end,))
            ]

        ),
      ),
    );
  }
}
