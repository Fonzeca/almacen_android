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
    if (articulos == null){
      EasyLoading.show();
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

           ),
         ),
       ),
     );
    }
  }
  
}