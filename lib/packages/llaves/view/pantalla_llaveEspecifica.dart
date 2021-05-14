import 'package:almacen_android/packages/llaves/bloc/bloc_llave_bloc.dart';
import 'package:almacen_android/packages/llaves/model/modelLlaves.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LlaveEspecifica extends StatelessWidget{

  String id;
  LlaveEspecifica({Key key, @required this.id}):super(key: key);
  Llave llave;


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LlaveBloc>(context).add(LlaveCargarLlave(id));
    return BlocListener<LlaveBloc, LlaveState>(listener: (context, state){
      if(state.carga){
        EasyLoading.show();
    }else{
        EasyLoading.dismiss();
      }
    },
    child: BlocBuilder<LlaveBloc,LlaveState>(
      builder: (context,state){
        if(llave == null){
          llave = state.llave;
          return Container();
        }else{
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
                        Expanded(child:
                        Text("Número de copia",style: TextStyle(color: Colors.grey),),
                        ),
                        Expanded(child:
                        Text("Nombre",style: TextStyle(color: Colors.grey),),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child:
                        Text(llave.copia),
                        ),
                        Expanded(
                          child:
                          Text(llave.nombre),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      children: [
                        Expanded(child: Text("Ubicación",style: TextStyle(color: Colors.grey),)),
                        Expanded(child: Text("Observaciones", style: TextStyle(color: Colors.grey),))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text(llave.ubicacion)),
                        Expanded(child: Text(llave.observaciones),)
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Center(
                      child: Text("Estado",style: TextStyle(color:Colors.grey, fontSize: 16),),
                    ),
                    Center(
                      child: Text(llave.estado,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 20.0,),
                    _buildButtons(context),
                  ],
                ),
              ),
            ),
          );

        }
      },
    ),);


  }


  Widget _buildButtons(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                style:
                ElevatedButton.styleFrom(primary:Colors.green),
                onPressed: ()=> registrarEntrada(context),
                child: Text("E",style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),)),
          ),
          SizedBox(width:20.0),
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary:Colors.red),
                onPressed: ()=> registrarSalida(context),
                child: Text("S", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),)),
          )
        ],
      ),
    );
  }

  registrarSalida(BuildContext context) {
    EasyLoading.showToast("Salida de la llave.");
    BlocProvider.of<LlaveBloc>(context).add(LlaveCambiarEstado(id,"En uso"));
  }

  registrarEntrada(BuildContext context) {
    EasyLoading.showToast("Entrada de la llave.");
    BlocProvider.of<LlaveBloc>(context).add(LlaveCambiarEstado(id,"Disponible"));
  }
}

