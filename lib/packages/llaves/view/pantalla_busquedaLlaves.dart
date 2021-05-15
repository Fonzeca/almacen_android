import 'package:almacen_android/packages/llaves/view/pantalla_llaveEspecifica.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuscarLlave extends StatelessWidget{
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Ingrese el ID de la llave"),
          Row(
            children: [
              TextField(keyboardType: TextInputType.number,controller: _controller,),
              TextButton(onPressed: ()=> _buscarLlave(context, _controller.text), child: Text("Buscar"))
            ],
          ),
        ],
      ),
    );

  }
  void _buscarLlave(BuildContext context, String id){
    LlaveEspecifica(id: id);
  }

}