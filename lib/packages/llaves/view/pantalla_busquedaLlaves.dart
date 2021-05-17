import 'package:almacen_android/packages/common/bloc/bloc_navigator_bloc.dart';
import 'package:almacen_android/packages/llaves/view/pantalla_llaveEspecifica.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuscarLlave extends StatelessWidget{
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(keyboardType: TextInputType.number, inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),]
                  ,controller: _controller, decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese el id de la llave'
                ),),
              ),
              TextButton(onPressed: ()=> _buscarLlave(context, _controller.text), child: Text("Buscar"))
            ],
          ),
        ],
      ),
    );

  }
  void _buscarLlave(BuildContext context, String id){
    BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPushPage(21,parametro: id));
  }

}