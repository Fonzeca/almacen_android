import 'package:almacen_android/packages/llaves/bloc/bloc_llaves_scanLlave_bloc.dart';
import 'package:almacen_android/packages/llaves/model/llave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanLlaves extends StatelessWidget{
  String identificacion;
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
            if(state.qrDetectado==""){
              _scannear(context);
              return Container();
            }else{
              identificacion = state.qrDetectado;
              BlocProvider.of<ScannearLlaveBloc>(context).add(ScannearLlaveBuscarLlave(identificacion));
              Llave llave = state.llave;
              return Container(
                child: _crearVista(llave, context),

              );
            }

          }),
    );

  }

  Future<void> _scannear (BuildContext context) async{
    await Permission.camera.request();
    String resultado= await FlutterBarcodeScanner.scanBarcode("#ff0000", "Cancelar", true, ScanMode.QR);
    if(resultado != null){
      if(RegExp(".{1,}-[0-9]{1,}").hasMatch(resultado)){
        BlocProvider.of<ScannearLlaveBloc>(context).add(ScannearLlaveCambiarQr(resultado));

      }else EasyLoading.showToast("El código scaneado no corresponde con una llave!\nPor favor inténtelo nuevamente.");
    }else EasyLoading.showToast("No se encontró código para scannear");
  }


  Widget _crearVista (Llave llave, BuildContext context){
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
    BlocProvider.of<ScannearLlaveBloc>(context).add(ScannearLlaveCambiarEstado(identificacion,"En uso"));
  }

  registrarEntrada(BuildContext context) {
    EasyLoading.showToast("Entrada de la llave.");
    BlocProvider.of<ScannearLlaveBloc>(context).add(ScannearLlaveCambiarEstado(identificacion,"Disponible"));
  }
}

