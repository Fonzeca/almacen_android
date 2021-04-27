import 'package:almacen_android/packages/llaves/data/api_calls.dart';
import 'package:almacen_android/packages/llaves/model/modelLlaves.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LlaveEspecifica extends StatelessWidget{
  final String id;
  Llave llave;
  ServidorLlaves _servidor = ServidorLlaves();
  ValueNotifier<int> valueNotifier= ValueNotifier(0);

  LlaveEspecifica({Key key, @required this.id}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: valueNotifier, builder:(context, value, child) {
      return otraFuncion(id);

    }, );

  }

  Widget otraFuncion(String id){
    if(llave == null){
      EasyLoading.show();
      _servidor.getLlaveEspecifica(id).then((value) {
        llave=value;
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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(llave.identificacion,textAlign: TextAlign.center,style: TextStyle(fontSize: 24),),
                // Text("inserte aquí la identificacion de la llave"),
                Divider(height: 0.5,color: Colors.orange,),
                Row(
                  children: [
                    Text("Número de copia",style: TextStyle(color: Colors.grey),),
                    Text("Nombre",style: TextStyle(color: Colors.grey),),
                  ],
                ),
                Row(
                  children: [
                    Text(llave.copia),
                    // Text("inserte n copia"),
                    Text(llave.nombre),
                    // Text("aca name"),
                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  children: [
                    Text("Ubicación",style: TextStyle(color: Colors.grey),),
                  ],
                ),
                Row(
                  children: [
                    Text(llave.ubicacion.nombre),
                  ],
                ),
                Center(
                  child: Text("Estado",style: TextStyle(color:Colors.grey),),
                ),
                Center(
                  child: Text(llave.estado,style: TextStyle(fontSize: 14),),
                ),
                Row(
                  children: [
                    Text("Observaciones", style: TextStyle(color: Colors.grey),),
                  ],
                ),
                Row(
                  children: [
                    Text(llave.observaciones),
                  ],
                ),
                SizedBox(height: 20.0,),
                _buildButtons(),
              ],
            ),
          ),
        ),
      );
    }
  }
}


Widget _buildButtons() {
  return Container(

    padding: EdgeInsets.symmetric(vertical: 15.0),
    width: double.infinity,
    child: Row(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary:Colors.green),
            onPressed: ()=> registrarEntrada(),
            child: Text("E",style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),)),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary:Colors.red),
            onPressed: ()=> registrarSalida(),
            child: Text("S", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),))
      ],
    ),
  );
}

registrarSalida() {
}

registrarEntrada() {
}