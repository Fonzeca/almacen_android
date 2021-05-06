import 'package:almacen_android/packages/llaves/bloc/bloc_llaves_scanLlave_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

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
              return Container(
                child: _crearVista(state.qrDetectado),

              );

            }else
              _scannear(context);
            return Container(color: Colors.lightBlue,);
          }),
    );

  }

  Future<void> _scannear (BuildContext context) async{
    await Permission.camera.request();
    String resultado= await scanner.scan();
    if(resultado != null){
      BlocProvider.of<ScannearLlaveBloc>(context).add(ScannearLlaveCambiarQr(resultado));
    }else EasyLoading.showToast("No se encontraron resultados");
  }

}

Widget _crearVista (String scanResult){
  return Column(
    children: [
      Text('Qr detectado:'+scanResult),
    ],
  );
}

