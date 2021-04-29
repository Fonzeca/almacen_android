import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/almacen/model/articulo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NuevoPedido extends StatelessWidget{
  final bool admn;
  List<Articulo> articulos;
  //TODO: esto lo puse como string pero capaz cambia a Usuario, maybe perhaps
  List<String> usuarios;
  Servidor _servidor = Servidor();
  ValueNotifier<int> valueNotifier = ValueNotifier(0);

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
      _servidor.listarUsuarios().then((value)=>usuarios=value);
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
               Text("Nuevo Pedido"),
               _crearVista(admn),
             ],

           ),
         ),
       ),
     );
    }
  }
  
}

Widget _crearVista (bool adm){
  if(adm){
    return Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Text("user 1"),
            Text("user 2"),
          ],
        ),
    );
  }else{
    return Container(
      child: Text("no sos admin"),
    );
  }
}