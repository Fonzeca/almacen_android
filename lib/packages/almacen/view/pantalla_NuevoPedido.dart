import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NuevoPedido extends StatelessWidget{
  final bool admn;
  List<Articulo> articulos;
  //TODO: esto lo puse como string pero capaz cambia a Usuario, maybe perhaps
  List<String> usuarios;
  Servidor _servidor = Servidor();
  ValueNotifier<int> valueNotifier = ValueNotifier(0);

  String dropdownValue;

  NuevoPedido({Key key, @required this.admn}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: valueNotifier, builder: (context, value, child) {
      return initializer();
    },);
  }

  Widget initializer() {
    if(admn && usuarios == null){
      EasyLoading.show();
      _servidor.listarUsuarios().then((value){
        usuarios=value;
        dropdownValue=usuarios.first;
      });
    }

    if (articulos == null){
      if(!EasyLoading.isShow)EasyLoading.show();
      _servidor.listarArticulos().then((value) {
        articulos = value;
        valueNotifier.value=1;
        EasyLoading.dismiss();
      });
      return Container();
    }else{
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
                _crearVista(admn),
              ],
            ),
          ),
        ),
      );
    }
  }
  Widget _crearVista (bool adm){
    if(adm){
      return Column(
        children: [
          Text("Usuario",style: TextStyle(color: Colors.grey),),
          DropdownButton<String>(
            value: dropdownValue,
            items: usuarios.map<DropdownMenuItem<String>>((String value){
              return DropdownMenuItem<String>(value : value,child: Text(value),);
            }).toList(),
            //TODO: ver por qué solo cambia una vez el usuario.
            onChanged: (String newValue){
              dropdownValue= newValue;
              valueNotifier.value=2;
            },
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10.0,),

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

}

