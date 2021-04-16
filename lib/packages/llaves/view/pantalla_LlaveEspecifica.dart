import 'package:almacen_android/packages/almacen/data/api_calls.dart';
import 'package:almacen_android/packages/llaves/data/api_calls.dart';
import 'package:almacen_android/packages/llaves/model/llave.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LlaveEspecifica extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ServidorLlaves _servidor = ServidorLlaves();
    Llave llave;
    //TODO: pasar el id verdadero.
    _servidor.getLlaveEspecifica("1").then((value) => llave=value);

    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
          mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Text(llave.identificacion,textAlign: TextAlign.center,style: TextStyle(fontSize: 24),),
              Text("inserte aquí la identificacion de la llave"),
              Divider(height: 0.5,color: Colors.orange,),
              Row(
                children: [
                  Text("Número de copia",style: TextStyle(color: Colors.grey),),
                  Text("Nombre",style: TextStyle(color: Colors.grey),),
                ],
              ),
              Row(
                children: [
                  // Text(llave.copia),
                  Text("inserte n copia"),
                  // Text(llave.nombre),
                  Text("aca name"),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Text("Ubicación",style: TextStyle(color: Colors.grey),),
                  Text("Descripción",style: TextStyle(color:Colors.grey),)
                ],
              ),
              Row(
                children: [
                  // Text(llave.ubicacion),
                  Text("ubiqueishon"),
                  Text("lorem"),
                  // Text(llave.descripcion),
                ],
              ),
              Center(
                child: Text("Estado",style: TextStyle(color:Colors.grey),),
              ),
              Center(
                child: Text("llave.estado",style: TextStyle(fontSize: 14),),
              ),
              Row(
                children: [
                  Text("Observaciones", style: TextStyle(color: Colors.grey),),
                ],
              ),
              Row(
                children: [
                  Text("llave.observaciones"),
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

Widget _buildButtons() {
  return Container(
    
    padding: EdgeInsets.symmetric(vertical: 15.0),
    width: double.infinity,
    child: Row(
      children: [
        ElevatedButton(onPressed: ()=> registrarEntrada(),
            child: Text("E",style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.green
            ),)),
        ElevatedButton(onPressed: ()=> registrarSalida(),
            child: Text("S", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              backgroundColor: Colors.red
            ),))
      ],
    ),
  );
}

registrarSalida() {
}

registrarEntrada() {
}