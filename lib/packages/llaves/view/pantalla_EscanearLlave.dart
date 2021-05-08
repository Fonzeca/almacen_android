import 'package:almacen_android/packages/llaves/bloc/bloc_llaves_scanLlave_bloc.dart';
import 'package:almacen_android/packages/llaves/model/llave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanLlaves extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ScannearLlaveBloc>(context).add(ScannearLlaveEventInitialize());
    return BlocListener<ScannearLlaveBloc,ScannearLlaveState>(
      listener: (context,state){
        if(state.carga){
          EasyLoading.show();
        }else EasyLoading.dismiss();
      },
      child: BlocBuilder<ScannearLlaveBloc,ScannearLlaveState>(
          builder: (context,state){
            if(state.qrDetectado!=null){
            String id = state.qrDetectado ;//TODO: cree esta variable por las dudas que hagamos algo en el medio, qsy
            BlocProvider.of<ScannearLlaveBloc>(context).add(ScannearLlaveBuscarLlave(id));
            Llave llave = state.llave;
              return Container(
                  child: _crearVista(llave),

              );

            }else
              _scannear(context);
            return Container(color: Colors.lightBlue,);
          }),
    );

  }

  Future<void> _scannear (BuildContext context) async{
    await Permission.camera.request();
    String resultado= await FlutterBarcodeScanner.scanBarcode("#ff0000", "Cancelar", true, ScanMode.QR);
    if(resultado != null){
      BlocProvider.of<ScannearLlaveBloc>(context).add(ScannearLlaveCambiarQr(resultado));
    }else EasyLoading.showToast("No se encontraron resultados");
  }


  Widget _crearVista (Llave llave){
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: <Widget>[
              Text(llave.identificacion,textAlign: TextAlign.center,style: TextStyle(fontSize: 24),),
              SizedBox(height: 10.0,),
              Divider(height: 0.5,color: Colors.orange,),
              SizedBox(height: 10.0,),
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
                  Expanded(child: Text(llave.ubicacion.nombre)),
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
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildButtons() {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
                style:
                ElevatedButton.styleFrom(primary:Colors.green),
                onPressed: ()=> registrarEntrada(),
                child: Text("E",style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),)),
          ),
          SizedBox(width:20.0),
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary:Colors.red),
                onPressed: ()=> registrarSalida(),
                child: Text("S", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),)),
          )
        ],
      ),
    );
  }

  registrarSalida() {
    EasyLoading.showToast("Salida de la llave.");
  }

  registrarEntrada() {
    EasyLoading.showToast("Entrada de la llave.");
  }
}

