
import 'package:almacen_android/packages/almacen/bloc/bloc_almacen_nuevoPedido_bloc.dart';
import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:almacen_android/packages/almacen/model/pojo/articulo_nvopedido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NuevoPedido extends StatelessWidget{
  final bool admn;
  //TODO: esto lo puse como string pero capaz cambia a Usuario, maybe perhaps

  NuevoPedido({Key key, @required this.admn}):super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoInitialize());
    return BlocBuilder<NuevoPedidoBloc,NuevoPedidoState>(
        builder: (context,state){
          if (state.listaArticulos == null){
            EasyLoading.show();
            return Container();
          }else{
            EasyLoading.dismiss();
            return Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Center(
                          child: Text("Nuevo Pedido",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))
                      ),
                      SizedBox(height: 10.0,),
                      Divider(height: 0.5,color: Colors.orange,),
                      SizedBox(height: 10.0,),
                      _crearVista(context, admn, state),
                    ],
                  ),
                ),
              ),
            );
          }
        }
    );
  }

  Widget _crearVista (BuildContext context, bool adm, NuevoPedidoState state){
    if(adm){
      return Column(
        children: [
          Text("Usuario",style: TextStyle(color: Colors.grey)),
          DropdownButton<String>(
            value: state.nombreUsuario,
            items: state.listaUsuarios.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(value : value,child: Text(value),);
            }).toList(),
            onChanged: (String newValue){
              BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventSetUser(newValue));
            },
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10.0,),
          Row(
            children: [
              TextField(decoration: const InputDecoration(hintText: "Artículo"),),
              TextField(decoration: const InputDecoration(hintText: "Cantidad"),
              keyboardType: TextInputType.number,maxLength: 3,),
              IconButton(icon: const Icon(Icons.add),
                onPressed: () { _agregarArt(context,"art","2"); },)
            ],
          ),
          SizedBox(height: 10.0),
          TextField(maxLength: 140, maxLines: 4,decoration: const InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 10.0),
            hintStyle: TextStyle(color: Colors.grey),
            hintText: "Observaciones",
          ),
          ),
        ],
      );
    }
    else{
      return Container(
        child: Text("no sos admin"),
      );
    }
  }

  void _agregarArt (BuildContext context, String nombre, String cant){
    BlocProvider.of<NuevoPedidoBloc>(context).add(NuevoPedidoEventAddArt(nombre, cant));
  }
}


